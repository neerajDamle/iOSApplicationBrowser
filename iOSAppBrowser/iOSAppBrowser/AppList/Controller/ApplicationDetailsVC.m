//
//  ApplicationDetailsVC.m
//  iOSAppBrowser
//
//  Created by Neeraj Damle on 1/29/16.
//  Copyright © 2016 Neeraj Damle. All rights reserved.
//

#import "ApplicationDetailsVC.h"

@interface ApplicationDetailsVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *applicationParameters;
}
@end

@implementation ApplicationDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    applicationParameters = @[APP_BUNDLE_ID,APP_BUNDLE_SHORT_VERSION,APP_BUNDLE_VERSION,APP_BUNDLE_SIGNER_IDENTITY,APP_BUNDLE_EXECUTABLE,APP_BUNDLE_ENTITLEMENTS,APP_BUNDLE_ENVIRONMENT_VARIABLES,APP_BUNDLE_URL,APP_BUNDLE_CONTAINER_URL,APP_NAME,APP_SHORT_NAME,APP_TYPE,APP_TEAM_ID,APP_VENDOR_NAME,APP_SOURCE_IDENTIFIER,APP_CONTAINER_URL,APP_DATA_CONTAINER_URL,APP_STORE_RECEIPT_URL,APP_CACHE_GUID,APP_UNIQUE_IDENTIFIER,APP_MACH_O_UUIDS,APP_INSTALL_TYPE,APP_ORIGINAL_INSTALL_TYPE,APP_SEQUENCE_NUMBER,APP_HASH,APP_FOUND_BACKING_BUNDLE,APP_PROFILE_VALIDATED,APP_IS_INSTALLED,APP_IS_RESTRICTED,APP_STORE_COHORT_METADATA,APP_TAGS];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    
    CGFloat requiredHeight = 0;
    UIFont *parameterFont = [UIFont fontWithName:@"Helvetica" size:16];
    UIFont *parameterValueFont = [UIFont fontWithName:@"Helvetica" size:11];
    
    CGSize maximumLableSize = CGSizeMake(self.view.frame.size.width-100, CGFLOAT_MAX);
    
//    NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading
//    NSStringDrawingUsesDeviceMetrics
    CGRect requiredSizeForParameter = [parameter boundingRectWithSize:maximumLableSize options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:parameterFont} context:nil];
    CGRect requiredSizeForParameterValue = [paramValue boundingRectWithSize:maximumLableSize options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:parameterValueFont} context:nil];
    
    requiredHeight += requiredSizeForParameter.size.height;
    requiredHeight += 5;   //Padding
    requiredHeight += requiredSizeForParameterValue.size.height;
    
    NSLog(@"Param value: %@",paramValue);
    NSLog(@"ParamValueHeight: %f",requiredSizeForParameterValue.size.height);
    NSLog(@"Font line height: %f",parameterValueFont.lineHeight);
    int paramValueNumberOfLines = ceil((requiredSizeForParameterValue.size.height) / parameterValueFont.lineHeight);
    
    NSLog(@"IndexPath: %d Height: %f Lines: %d",indexPath.row,requiredHeight,paramValueNumberOfLines);
    
    NSInteger extraPadding = 0;
    switch (paramValueNumberOfLines)
    {
        case 0:
        case 1:
        {
            extraPadding = 10;
            break;
        }
        default:
        {
            extraPadding = ((paramValueNumberOfLines-2)*10);
            break;
        }
    }
    
    requiredHeight += extraPadding;
    
//        return UITableViewAutomaticDimension;
    return requiredHeight;
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
    else if([value isKindOfClass:[NSUUID class]])
    {
        paramValue = [value UUIDString];
    }
    else if([value isKindOfClass:[NSArray class]])
    {
        paramValue = @"Array";
    }
    else if([value isKindOfClass:[NSDictionary class]])
    {
        paramValue = @"Dictionary";
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
