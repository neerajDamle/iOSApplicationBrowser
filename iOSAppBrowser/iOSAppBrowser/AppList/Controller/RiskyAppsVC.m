//
//  RiskyAppsVC.m
//  iOSAppBrowser
//
//  Created by Madhura Marathe on 2/7/16.
//  Copyright © 2016 Neeraj Damle. All rights reserved.
//

#import "RiskyAppsVC.h"
#import "Application.h"
#import "ApplicationDetailsVC.h"
#import "CommonConstants.h"

static NSString *APPLE_SIGNER_IDENTITY = @"Apple iPhone OS Application Signing";
static NSString *APPLE_STORE_FRONT = @"143441";

static NSString *DEVELOPER_SIGNER_IDENTITY = @"iPhone Developer:";
static NSString *THIRD_PARTY_DISTRIBUTION_SIGNER_IDENTITY = @"iPhone Distribution:";
static NSString *UNKNOWN_STORE_FRONT = @"0";

@interface RiskyAppsVC () <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *riskyApplications;
    NSMutableArray *visibleApplications;
    NSInteger selectedRow;
    NSInteger selectedSignerCategory;
}
@property (strong, nonatomic) IBOutlet UISegmentedControl *appSignerTypeSegmentControl;
@property (strong, nonatomic) IBOutlet UITableView *riskyAppsTableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@end

@implementation RiskyAppsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"Risky Applications";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor lightGrayColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self action:@selector(refreshRiskyAppsList) forControlEvents:UIControlEventValueChanged];
    [self.riskyAppsTableView addSubview:self.refreshControl];
    
    selectedSignerCategory = 0;
    
    [self identifyPotentiallyRiskyApps];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Identify risky apps
- (void)identifyPotentiallyRiskyApps
{
    if(riskyApplications == nil)
    {
        riskyApplications = [[NSMutableArray alloc] init];
    }
    else
    {
        [riskyApplications removeAllObjects];
    }
    
    //1. Check if the app is signed with "Apple iPhone OS Application Signing"
        //1.1 If yes, check "store front" value.
        // - If it is "143441" that means it has been downloaded from
        //   official Apple AppStore
        // - If it is "0" that means it has been installed by some other way
    //2. If it is signed with "iPhone Distribution: xxx", it is potentially risky app
        //Also verify "application_identifier" entitlement to check whether bundle ids match
    
    for (Application *currentApplication in self.applications)
    {
        if([currentApplication.type isEqualToString:APP_CATEGORY_USER])
        {
            if([currentApplication.signerIdentity isEqualToString:APPLE_SIGNER_IDENTITY])
            {
                NSNumber *storeFront = currentApplication.storeFront;
                NSString *strStoreFront = [storeFront stringValue];
                if([strStoreFront isEqualToString:APPLE_STORE_FRONT])
                {
                    //Application is signed by Apple certificate and is installed from Apple AppStore
                }
                else if([strStoreFront isEqualToString:UNKNOWN_STORE_FRONT])
                {
                    //Application is signed by Apple certificate but not installed from Apple AppStore
                    //Could be a sideloaded application
                    [riskyApplications addObject:currentApplication];
                }
            }
            else if([currentApplication.signerIdentity hasPrefix:THIRD_PARTY_DISTRIBUTION_SIGNER_IDENTITY])
            {
                [riskyApplications addObject:currentApplication];
            }
            else if([currentApplication.signerIdentity hasPrefix:DEVELOPER_SIGNER_IDENTITY])
            {
                [riskyApplications addObject:currentApplication];
            }
        }
    }
    
    NSString *signerCategory = nil;
    switch (selectedSignerCategory)
    {
        case 0:
            signerCategory = APPLE_SIGNER_IDENTITY;
            break;
        case 1:
            signerCategory = THIRD_PARTY_DISTRIBUTION_SIGNER_IDENTITY;
            break;
        case 2:
            signerCategory = DEVELOPER_SIGNER_IDENTITY;
            break;
        default:
            signerCategory = THIRD_PARTY_DISTRIBUTION_SIGNER_IDENTITY;
            break;
    }
    
    [self loadApplicationsForSigner:signerCategory];
}

#pragma mark - Update application list based on signer
- (void)loadApplicationsForSigner:(NSString *)signerCategory
{
    if(visibleApplications == nil)
    {
        visibleApplications = [[NSMutableArray alloc] init];
    }
    else
    {
        [visibleApplications removeAllObjects];
    }
    
    for (Application *currentApplication in riskyApplications)
    {
        if([currentApplication.signerIdentity hasPrefix:signerCategory])
        {
            [visibleApplications addObject:currentApplication];
        }
    }
    
    [self.riskyAppsTableView reloadData];
}

#pragma mark - Segment Control click event
/**
 * Updated tableview with applications of selected signer type
 * @author Neeraj Damle
 *
 * @param
 * @return
 */
- (IBAction)changeApplicationBySignerType:(id)sender
{
    selectedSignerCategory = ((UISegmentedControl *) sender).selectedSegmentIndex;
    
    switch (((UISegmentedControl *) sender).selectedSegmentIndex)
    {
        case 0: //Apple
        {
            [self loadApplicationsForSigner:APPLE_SIGNER_IDENTITY];
            break;
        }
        case 1: //Distribution
        {
            [self loadApplicationsForSigner:THIRD_PARTY_DISTRIBUTION_SIGNER_IDENTITY];
            break;
        }
        default:  //Developer
        {
            [self loadApplicationsForSigner:DEVELOPER_SIGNER_IDENTITY];
            break;
        }
    }
}

#pragma mark - Refresh risky application list
- (void)refreshRiskyAppsList
{
    [self identifyPotentiallyRiskyApps];
    selectedRow = -1;
    
    [self.riskyAppsTableView reloadData];
    
    // End the refreshing
    if (self.refreshControl)
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
        
        [self.refreshControl endRefreshing];
    }
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return visibleApplications.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RiskyAppListCell"];
    
    Application *application = [visibleApplications objectAtIndex:indexPath.row];
    cell.textLabel.text = application.name;
    
    NSString *strIconImage = application.iconImage;
    if(![strIconImage isEqualToString:@""])
    {
        NSData *imageData = [[NSData alloc] initWithBase64EncodedString:strIconImage options:NSDataBase64DecodingIgnoreUnknownCharacters];
        if(imageData)
        {
            UIImage *iconImage = [[UIImage alloc] initWithData:imageData];
            cell.imageView.image = iconImage;
        }
    }
    
    return cell;
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedRow = indexPath.row;
    [self performSegueWithIdentifier:@"riskyApplicationDetailsSegue" sender:self];
}

#pragma mark - Segue navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"riskyApplicationDetailsSegue"])
    {
        Application *application = [visibleApplications objectAtIndex:selectedRow];
        
        ApplicationDetailsVC *applicationDetailsVC = (ApplicationDetailsVC *)segue.destinationViewController;
        applicationDetailsVC.application = application;
    }
}

@end
