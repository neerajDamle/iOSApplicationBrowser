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

@interface ApplicationListVC () <UITableViewDataSource,UITableViewDelegate>
{
    NSArray *applications;
    NSInteger selectedRow;
}
@property (strong, nonatomic) IBOutlet UITableView *appListTableView;

@end

@implementation ApplicationListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.title = @"Applications";
    
    applications = [BrowseAllInstalledApplication browseInstalledAppList];
    selectedRow = -1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return applications.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppListCell"];
    
    Application *application = [applications objectAtIndex:indexPath.row];
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
        Application *application = [applications objectAtIndex:selectedRow];
        
        ApplicationDetailsVC *applicationDetailsVC = (ApplicationDetailsVC *)segue.destinationViewController;
        applicationDetailsVC.application = application;
    }
}
@end
