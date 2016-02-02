//
//  Application.h
//  iOSAppBrowser
//
//  Created by Neeraj Damle on 1/29/16.
//  Copyright © 2016 Neeraj Damle. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *APP_BUNDLE_ID = @"bundleid";
static NSString *APP_BUNDLE_SHORT_VERSION = @"bundleShortVersion";
static NSString *APP_BUNDLE_VERSION = @"bundleVersion";
static NSString *APP_NAME = @"appName";
static NSString *APP_TEAM_ID = @"teamID";
static NSString *APP_VENDOR_NAME = @"vendorName";
static NSString *APP_SIGNER_IDENTITY = @"signerIdentity";
static NSString *APP_INSTALL_TYPE = @"installType";
static NSString *APP_ORIGINAL_INSTALL_TYPE = @"originalInstallType";
static NSString *APP_PROFILE_VALIDATED = @"profileValidated";
static NSString *APP_SOURCE_IDENTIFIER = @"sourceIdentifier";
static NSString *APP_IS_INSTALLED = @"isInstalled";
static NSString *APP_IS_RESTRICTED = @"isRestricted";
static NSString *APP_STORE_COHORT_METADATA = @"storeCohortMetadata";
static NSString *APP_TAGS = @"appTags";

@interface Application : NSObject

@property (nonatomic,readwrite) NSString *bundleID;
@property (nonatomic,readwrite) NSString *name;
@property (nonatomic,readwrite) NSString *bundleShortVersion;
@property (nonatomic,readwrite) NSString *bundleVersion;
@property (nonatomic, readwrite) NSString *iconImage;
@property (nonatomic,readwrite) NSString *teamID;
@property (nonatomic,readwrite) NSString *vendorName;
@property (nonatomic,readwrite) NSString *signerIdentity;
@property (nonatomic,readwrite) NSString *sourceAppIdentifier;
@property (getter=isProfileValidated,nonatomic,readwrite) BOOL profileValidated;
@property (nonatomic,readwrite) unsigned long long installType;
@property (nonatomic,readwrite) unsigned long long originalInstallType;
@property (nonatomic,readwrite) BOOL isInstalled;
@property (nonatomic,readwrite) BOOL isRestricted;
@property (nonatomic,readwrite) NSString *storeCohortMetadata;
@property (nonatomic,readwrite) NSString *tags;

- (Application *)initWithBundleID:(NSString *)bundleID name:(NSString *)name version:(NSString *)version;
- (id)getValueForKey:(NSString *)key;

@end
