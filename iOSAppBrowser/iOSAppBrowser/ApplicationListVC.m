//
//  ApplicationListVC.m
//  iOSAppBrowser
//
//  Created by Neeraj Damle on 1/27/16.
//  Copyright © 2016 Neeraj Damle. All rights reserved.
//

#import "ApplicationListVC.h"
#import "BrowseAllInstalledApplication.h"
#import "Application.h"
#import "ApplicationDetailsVC.h"
#import "RiskyAppsVC.h"
#import "CommonConstants.h"

@interface ApplicationListVC () <UITableViewDataSource,UITableViewDelegate>
{
    NSArray *applications;
    NSMutableArray *visibleApplications;
    NSInteger selectedRow;
}
@property (strong, nonatomic) IBOutlet UISegmentedControl *appTypeSegmentControl;
@property (strong, nonatomic) IBOutlet UITableView *appListTableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@end

@implementation ApplicationListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.title = @"Applications";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor lightGrayColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self action:@selector(refreshAppList) forControlEvents:UIControlEventValueChanged];
    [self.appListTableView addSubview:self.refreshControl];
    
//    [BrowseAllInstalledApplication getDeviceDetails];
//    [BrowseAllInstalledApplication getAccountDetails];
//    [BrowseAllInstalledApplication getNetworkDetails];
    
    applications = [BrowseAllInstalledApplication browseInstalledAppList];
    [self loadApplicationsForCategory:APP_CATEGORY_USER];
    selectedRow = -1;
    
    [self addWarningButton];
    
//    NSString *bundleID = @"com.bigcavegames.blockybird3d";
//    [BrowseAllInstalledApplication openApplicationWithBundleID:bundleID];
//    [BrowseAllInstalledApplication getBundleDetails:bundleID];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addWarningButton
{
    UIImage* warningImage = [UIImage imageNamed:@"Warning"];
    CGRect frameImg = CGRectMake(0, 0, warningImage.size.width, warningImage.size.height);
    UIButton *someButton = [[UIButton alloc] initWithFrame:frameImg];
    [someButton setBackgroundImage:warningImage forState:UIControlStateNormal];
    [someButton addTarget:self action:@selector(showRiskyApps) forControlEvents:UIControlEventTouchUpInside];
    [someButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *warningButton =[[UIBarButtonItem alloc] initWithCustomView:someButton];
    self.navigationItem.rightBarButtonItem = warningButton;
}

#pragma mark - Refresh application list
- (void)refreshAppList
{
    applications = [BrowseAllInstalledApplication browseInstalledAppList];
    [self loadApplicationsForCategory:APP_CATEGORY_USER];
    selectedRow = -1;
    
    [self.appListTableView reloadData];
    
    // End the refreshing
    if (self.refreshControl)
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        self.refreshControl.attributedTitle = attributedTitle;
        
        [self.refreshControl endRefreshing];
    }
}

#pragma mark - Update application list based on category
- (void)loadApplicationsForCategory:(NSString *)applicationCategory
{
    if(visibleApplications == nil)
    {
        visibleApplications = [[NSMutableArray alloc] init];
    }
    else
    {
        [visibleApplications removeAllObjects];
    }
    
    for (Application *currentApplication in applications)
    {
        if([currentApplication.type isEqualToString:applicationCategory])
        {
            [visibleApplications addObject:currentApplication];
        }
    }
    
    [self.appListTableView reloadData];
}

#pragma mark - Segment Control click event
/**
 * Updated tableview with applications of selected type
 * @author Neeraj Damle
 *
 * @param
 * @return
 */
- (IBAction)changeApplicationType:(id)sender
{
    switch (((UISegmentedControl *) sender).selectedSegmentIndex)
    {
        case 0: //User
        {
            [self loadApplicationsForCategory:APP_CATEGORY_USER];
            break;
        }
        case 1: //System
        {
            [self loadApplicationsForCategory:APP_CATEGORY_SYSTEM];
            break;
        }
        default:  //User
        {
            [self loadApplicationsForCategory:APP_CATEGORY_USER];
            break;
        }
    }
}

#pragma mark - Warning button click event
- (void)showRiskyApps
{
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if(storyBoard)
    {
        RiskyAppsVC *riskyAppsVC = [storyBoard instantiateViewControllerWithIdentifier:@"RiskyAppsVC"];
        riskyAppsVC.applications = applications;
        
        [self.navigationController pushViewController:riskyAppsVC animated:YES];
    }
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return visibleApplications.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppListCell"];
    
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
    [self performSegueWithIdentifier:@"applicationDetailsSegue" sender:self];
}

#pragma mark - Segue navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"applicationDetailsSegue"])
    {
        Application *application = [visibleApplications objectAtIndex:selectedRow];
        
        ApplicationDetailsVC *applicationDetailsVC = (ApplicationDetailsVC *)segue.destinationViewController;
        applicationDetailsVC.application = application;
    }
}
@end
