//
//  Application.h
//  iOSAppBrowser
//
//  Created by Neeraj Damle on 1/29/16.
//  Copyright © 2016 Neeraj Damle. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *APP_BUNDLE_ID = @"Bundle ID";
static NSString *APP_BUNDLE_SHORT_VERSION = @"Bundle Short Version";
static NSString *APP_BUNDLE_VERSION = @"Bundle Version";
static NSString *APP_BUNDLE_SIGNER_IDENTITY = @"Bundle Signer Identity";
static NSString *APP_BUNDLE_EXECUTABLE = @"Bundle Executable";
static NSString *APP_BUNDLE_ENTITLEMENTS = @"Bundle Entitlements";
static NSString *APP_BUNDLE_ENVIRONMENT_VARIABLES = @"Bundle Environment Variables";
static NSString *APP_BUNDLE_URL = @"Bundle URL";
static NSString *APP_BUNDLE_CONTAINER_URL = @"Bundle Container URL";

static NSString *APP_NAME = @"Name";
static NSString *APP_SHORT_NAME = @"Short Name";
static NSString *APP_TYPE = @"Type";
static NSString *APP_TEAM_ID = @"Team ID";
static NSString *APP_VENDOR_NAME = @"Vendor Name";
static NSString *APP_SOURCE_IDENTIFIER = @"Source Identifier";
static NSString *APP_STORE_NAME = @"Store Name";
static NSString *APP_REGISTERED_DATE = @"Registered Date";

static NSString *APP_CONTAINER_URL = @"Container URL";
static NSString *APP_DATA_CONTAINER_URL = @"Data Container URL";

static NSString *APP_STORE_RECEIPT_URL = @"AppStore Receipt URL";
static NSString *APP_STORE_FRONT = @"Store Front";
static NSString *APP_PURCHASER_DSID = @"Purchaser DSID";
static NSString *APP_APPLICATION_DSID = @"Application DSID";

static NSString *APP_CACHE_GUID = @"Cache GUID";
static NSString *APP_UNIQUE_IDENTIFIER = @"Unique Identifier";
static NSString *APP_MACH_O_UUIDS = @"Mach O UUIDs";

static NSString *APP_INSTALL_TYPE = @"Install Type";
static NSString *APP_ORIGINAL_INSTALL_TYPE = @"Original Install Type";
static NSString *APP_SEQUENCE_NUMBER = @"Sequence Number";
static NSString *APP_HASH = @"Bundle Hash";

static NSString *APP_FOUND_BACKING_BUNDLE = @"Found Backing Bundle";

static NSString *APP_IS_ADHOC_CODE_SIGNED = @"Is AdHoc Code Signed";
static NSString *APP_PROFILE_VALIDATED = @"Profile Validated";
static NSString *APP_IS_INSTALLED = @"Is Installed";
static NSString *APP_IS_RESTRICTED = @"Is Restricted";

static NSString *APP_STORE_COHORT_METADATA = @"Store Cohort Metadata";
static NSString *APP_UI_BACKGROUND_MODES = @"UI Background Modes";
static NSString *APP_TAGS = @"Application Tags";
static NSString *APP_COMPANION_APP_IDENTIFIER = @"Companion Application Identifier";

@interface Application : NSObject

@property (nonatomic,readwrite) NSString *bundleID;
@property (nonatomic,readwrite) NSString *bundleShortVersion;
@property (nonatomic,readwrite) NSString *bundleVersion;
@property (nonatomic,readwrite) NSString *signerIdentity;
@property (nonatomic,readwrite) NSString *bundleExecutable;
@property (nonatomic,readwrite) NSDictionary *entitlements;
@property (nonatomic,readwrite) NSDictionary *environmentVariables;
@property (nonatomic,readwrite) NSString *bundleURL;
@property (nonatomic,readwrite) NSString *bundleContainerURL;

@property (nonatomic,readwrite) NSString *name;
@property (nonatomic,readwrite) NSString *shortName;
@property (nonatomic,readwrite) NSString *type;
@property (nonatomic,readwrite) NSString *teamID;
@property (nonatomic,readwrite) NSString *vendorName;
@property (nonatomic,readwrite) NSString *sourceAppIdentifier;
@property (nonatomic,readwrite) NSString *storeName;
@property (nonatomic,readwrite) NSDate *registeredDate;
@property (nonatomic, readwrite) NSString *iconImage;

@property (nonatomic,readwrite) NSString *containerURL;
@property (nonatomic,readwrite) NSString *dataContainerURL;

@property (nonatomic,readwrite) NSString *appStoreReceiptURL;
@property (nonatomic,readwrite) NSNumber *storeFront;
@property (nonatomic,readwrite) NSNumber *purchaserDSID;
@property (nonatomic,readwrite) NSString *applicationDSID;

@property (nonatomic,readwrite) NSUUID *cacheGUID;
@property (nonatomic,readwrite) NSUUID *uniqueIdentifier;
@property (nonatomic,readwrite) NSArray *machOUUIDs;

@property (nonatomic,readwrite) unsigned long long installType;
@property (nonatomic,readwrite) unsigned long long originalInstallType;
@property (nonatomic,readwrite) unsigned int sequenceNumber;
@property (nonatomic,readwrite) unsigned int appHash;

@property (nonatomic,readwrite) BOOL foundBackingBundle;

@property (nonatomic,readwrite) BOOL isAdHocCodeSigned;
@property (getter=isProfileValidated,nonatomic,readwrite) BOOL profileValidated;
@property (nonatomic,readwrite) BOOL isInstalled;
@property (nonatomic,readwrite) BOOL isRestricted;

@property (nonatomic,readwrite) NSString *storeCohortMetadata;
@property (nonatomic,readwrite) NSArray *uiBackgroundModes;
@property (nonatomic,readwrite) NSArray *tags;
@property (nonatomic,readwrite) NSString *companionAppIdentifier;

- (Application *)initWithBundleID:(NSString *)bundleID name:(NSString *)name version:(NSString *)version;
- (id)getValueForKey:(NSString *)key;

@end
