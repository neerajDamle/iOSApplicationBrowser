//
//  ApplicationDetailsVC.m
//  iOSAppBrowser
//
//  Created by Neeraj Damle on 1/29/16.
//  Copyright © 2016 Neeraj Damle. All rights reserved.
//

#import "ApplicationDetailsVC.h"

@interface ApplicationDetailsVC ()<UITableViewDataSource>
{
    NSArray *applicationParameters;
}
@end

@implementation ApplicationDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    applicationParameters = @[APP_BUNDLE_ID,APP_BUNDLE_SHORT_VERSION,APP_BUNDLE_VERSION,APP_NAME,APP_TEAM_ID,APP_VENDOR_NAME,APP_SIGNER_IDENTITY,APP_INSTALL_TYPE,APP_ORIGINAL_INSTALL_TYPE,APP_PROFILE_VALIDATED,APP_SOURCE_IDENTIFIER,APP_IS_INSTALLED,APP_IS_RESTRICTED,APP_STORE_COHORT_METADATA,APP_TAGS];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return applicationParameters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *applicationDetailsCell = [tableView dequeueReusableCellWithIdentifier:@"ApplicationDetailsCell"];
    
    NSString *parameter = [applicationParameters objectAtIndex:indexPath.row];
    NSString *paramValue = nil;
    id value = [self.application getValueForKey:parameter];
    if([value isKindOfClass:[NSString class]])
    {
        paramValue = value;
    }
    else if([value isKindOfClass:[NSNumber class]])
    {
        paramValue = [value stringValue];
    }
    
    applicationDetailsCell.textLabel.text = parameter;
    applicationDetailsCell.detailTextLabel.text = paramValue;
    
    return applicationDetailsCell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
