//
//  Application.m
//  iOSAppBrowser
//
//  Created by Neeraj Damle on 1/29/16.
//  Copyright © 2016 Neeraj Damle. All rights reserved.
//

#import "Application.h"

@implementation Application

- (Application *)initWithBundleID:(NSString *)bundleID name:(NSString *)name version:(NSString *)version
{
    self = [super init];
    if(self)
    {
        _bundleID = bundleID;
        _name = name;
        _bundleShortVersion = @"";
        _bundleVersion = version;
        _iconImage = nil;
        _teamID = @"";
        _vendorName = @"";
        _sourceAppIdentifier = @"";
        _profileValidated = NO;
        _installType = 0;
        _originalInstallType = 0;
        _isInstalled = YES;
        _isRestricted = NO;
        _storeCohortMetadata = @"";
        _tags = @"";
    }
    
    return self;
}

- (id)getValueForKey:(NSString *)key
{
    id value = nil;
    if([key isEqualToString:APP_BUNDLE_ID])
    {
        value = self.bundleID;
    }
    else if([key isEqualToString:APP_BUNDLE_SHORT_VERSION])
    {
        value = self.bundleShortVersion;
    }
    if([key isEqualToString:APP_BUNDLE_VERSION])
    {
        value = self.bundleVersion;
    }
    else if([key isEqualToString:APP_NAME])
    {
        value = self.name;
    }
    if([key isEqualToString:APP_TEAM_ID])
    {
        value = self.teamID;
    }
    else if([key isEqualToString:APP_VENDOR_NAME])
    {
        value = self.vendorName;
    }
    if([key isEqualToString:APP_INSTALL_TYPE])
    {
        NSNumber *numInstallType = [NSNumber numberWithUnsignedLongLong:self.installType];
        value = numInstallType;
    }
    else if([key isEqualToString:APP_ORIGINAL_INSTALL_TYPE])
    {
        NSNumber *numOriginalInstallType = [NSNumber numberWithUnsignedLongLong:self.originalInstallType];
        value = numOriginalInstallType;
    }
    if([key isEqualToString:APP_PROFILE_VALIDATED])
    {
        NSNumber *numIsProfileValidated = [NSNumber numberWithBool:self.profileValidated];
        value = numIsProfileValidated;
    }
    else if([key isEqualToString:APP_SOURCE_IDENTIFIER])
    {
        value = self.sourceAppIdentifier;
    }
    if([key isEqualToString:APP_IS_INSTALLED])
    {
        NSNumber *numIsInstalled = [NSNumber numberWithBool:self.isInstalled];
        value = numIsInstalled;
    }
    else if([key isEqualToString:APP_IS_RESTRICTED])
    {
        NSNumber *numIsRestricted = [NSNumber numberWithBool:self.isRestricted];
        value = numIsRestricted;
    }
    if([key isEqualToString:APP_STORE_COHORT_METADATA])
    {
        value = self.storeCohortMetadata;
    }
    else if([key isEqualToString:APP_TAGS])
    {
        value = self.tags;
    }
    return value;
}

@end
