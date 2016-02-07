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

@interface RiskyAppsVC () <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *riskyApplications;
    NSInteger selectedRow;
}
@property (strong, nonatomic) IBOutlet UITableView *riskyAppsTableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;
@end

@implementation RiskyAppsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"Risky Applications";
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor lightGrayColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self action:@selector(refreshRiskyAppsList) forControlEvents:UIControlEventValueChanged];
//    [self.riskyAppsTableView addSubview:self.refreshControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return riskyApplications.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RiskyAppListCell"];
    
    Application *application = [riskyApplications objectAtIndex:indexPath.row];
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
        Application *application = [riskyApplications objectAtIndex:selectedRow];
        
        ApplicationDetailsVC *applicationDetailsVC = (ApplicationDetailsVC *)segue.destinationViewController;
        applicationDetailsVC.application = application;
    }
}

@end
