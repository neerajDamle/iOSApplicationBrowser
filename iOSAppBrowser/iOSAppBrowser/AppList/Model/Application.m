//
//  Application.m
//  iOSAppBrowser
//
//  Created by Neeraj Damle on 1/29/16.
//  Copyright © 2016 Neeraj Damle. All rights reserved.
//

#import "Application.h"

@implementation Application

static NSDictionary *storeFrontMapping = nil;

+ (void)initStoreMapping
{
    if(storeFrontMapping == nil)
    {
        storeFrontMapping = @{
                                @"143563": @"Algeria",
                                @"143564": @"Angola",
                                @"143538": @"Anguilla",
                                @"143540": @"Antigua & Barbuda",
                                @"143505": @"Argentina",
                                @"143524": @"Armenia",
                                @"143460": @"Australia",
                                @"143445": @"Austria",
                                @"143568": @"Azerbaijan",
                                @"143559": @"Bahrain",
                                @"143490": @"Bangladesh",
                                @"143541": @"Barbados",
                                @"143565": @"Belarus",
                                @"143446": @"Belgium",
                                @"143555": @"Belize",
                                @"143542": @"Bermuda",
                                @"143556": @"Bolivia",
                                @"143525": @"Botswana",
                                @"143503": @"Brazil",
                                @"143543": @"British Virgin Islands",
                                @"143560": @"Brunei",
                                @"143526": @"Bulgaria",
                                @"143455": @"Canada",
                                @"143544": @"Cayman Islands",
                                @"143483": @"Chile",
                                @"143465": @"China",
                                @"143501": @"Colombia",
                                @"143495": @"Costa Rica",
                                @"143527": @"Cote D'Ivoire",
                                @"143494": @"Croatia",
                                @"143557": @"Cyprus",
                                @"143489": @"Czech Republic",
                                @"143458": @"Denmark",
                                @"143545": @"Dominica",
                                @"143508": @"Dominican Rep.",
                                @"143509": @"Ecuador",
                                @"143516": @"Egypt",
                                @"143506": @"El Salvador",
                                @"143518": @"Estonia",
                                @"143447": @"Finland",
                                @"143442": @"France",
                                @"143443": @"Germany",
                                @"143573": @"Ghana",
                                @"143448": @"Greece",
                                @"143546": @"Grenada",
                                @"143504": @"Guatemala",
                                @"143553": @"Guyana",
                                @"143510": @"Honduras",
                                @"143463": @"Hong Kong",
                                @"143482": @"Hungary",
                                @"143558": @"Iceland",
                                @"143467": @"India",
                                @"143476": @"Indonesia",
                                @"143449": @"Ireland",
                                @"143491": @"Israel",
                                @"143450": @"Italy",
                                @"143511": @"Jamaica",
                                @"143462": @"Japan",
                                @"143528": @"Jordan",
                                @"143517": @"Kazakstan",
                                @"143529": @"Kenya",
                                @"143466": @"Korea, Republic Of",
                                @"143493": @"Kuwait",
                                @"143519": @"Latvia",
                                @"143497": @"Lebanon",
                                @"143522": @"Liechtenstein",
                                @"143520": @"Lithuania",
                                @"143451": @"Luxembourg",
                                @"143515": @"Macau",
                                @"143530": @"Macedonia",
                                @"143531": @"Madagascar",
                                @"143473": @"Malaysia",
                                @"143488": @"Maldives",
                                @"143532": @"Mali",
                                @"143521": @"Malta",
                                @"143533": @"Mauritius",
                                @"143468": @"Mexico",
                                @"143523": @"Moldova, Republic Of",
                                @"143547": @"Montserrat",
                                @"143484": @"Nepal",
                                @"143452": @"Netherlands",
                                @"143461": @"New Zealand",
                                @"143512": @"Nicaragua",
                                @"143534": @"Niger",
                                @"143561": @"Nigeria",
                                @"143457": @"Norway",
                                @"143562": @"Oman",
                                @"143477": @"Pakistan",
                                @"143485": @"Panama",
                                @"143513": @"Paraguay",
                                @"143507": @"Peru",
                                @"143474": @"Philippines",
                                @"143478": @"Poland",
                                @"143453": @"Portugal",
                                @"143498": @"Qatar",
                                @"143487": @"Romania",
                                @"143469": @"Russia",
                                @"143479": @"Saudi Arabia",
                                @"143535": @"Senegal",
                                @"143500": @"Serbia",
                                @"143464": @"Singapore",
                                @"143496": @"Slovakia",
                                @"143499": @"Slovenia",
                                @"143472": @"South Africa",
                                @"143454": @"Spain",
                                @"143486": @"Sri Lanka",
                                @"143548": @"St. Kitts & Nevis",
                                @"143549": @"St. Lucia",
                                @"143550": @"St. Vincent & The Grenadines",
                                @"143554": @"Suriname",
                                @"143456": @"Sweden",
                                @"143459": @"Switzerland",
                                @"143470": @"Taiwan",
                                @"143572": @"Tanzania",
                                @"143475": @"Thailand",
                                @"143539": @"The Bahamas",
                                @"143551": @"Trinidad & Tobago",
                                @"143536": @"Tunisia",
                                @"143480": @"Turkey",
                                @"143552": @"Turks & Caicos",
                                @"143537": @"Uganda",
                                @"143444": @"UK",
                                @"143492": @"Ukraine",
                                @"143481": @"United Arab Emirates",
                                @"143514": @"Uruguay",
                                @"143441": @"USA",
                                @"143566": @"Uzbekistan",
                                @"143502": @"Venezuela",
                                @"143471": @"Vietnam",
                                @"143571": @"Yemen"
                              };
    }
}

- (Application *)init
{
    self = [super init];
    if(self)
    {
        [[self class] initStoreMapping];
        
        _bundleID = @"";
        _bundleShortVersion = @"";
        _bundleVersion = @"";
        _signerIdentity = @"";
        _bundleExecutable = @"";
        _entitlements = nil;
        _environmentVariables = nil;
        _bundleURL = @"";
        _bundleContainerURL = @"";
        
        _name = @"";
        _shortName = @"";
        _type = @"";
        _teamID = @"";
        _vendorName = @"";
        _sourceAppIdentifier = @"";
        _storeName = @"Unknown";
        _registeredDate = nil;
        _iconImage = nil;
        
        _containerURL = @"";
        _dataContainerURL = @"";
        
        _appStoreReceiptURL = @"";
        _storeFront = nil;
        _purchaserDSID = nil;
        
        _cacheGUID = nil;
        _uniqueIdentifier = nil;
        _machOUUIDs = nil;
        
        _installType = 0;
        _originalInstallType = 0;
        _sequenceNumber = 0;
        _appHash = 0;
        
        _foundBackingBundle = YES;
        
        _isAdHocCodeSigned = NO;
        _profileValidated = NO;
        _isInstalled = YES;
        _isRestricted = NO;
        
        _storeCohortMetadata = @"";
        _uiBackgroundModes = nil;
        _tags = nil;
        _companionAppIdentifier = @"";
    }
    
    return  self;
}

- (Application *)initWithBundleID:(NSString *)bundleID name:(NSString *)name version:(NSString *)version
{
    self = [super init];
    if(self)
    {
        [[self class] initStoreMapping];
        
        _bundleID = bundleID;
        _bundleShortVersion = @"";
        _bundleVersion = version;
        _signerIdentity = @"";
        _bundleExecutable = @"";
        _entitlements = nil;
        _environmentVariables = nil;
        _bundleURL = @"";
        _bundleContainerURL = @"";
        
        _name = name;
        _shortName = @"";
        _type = @"";
        _teamID = @"";
        _vendorName = @"";
        _sourceAppIdentifier = @"";
        _storeName = @"Unknown";
        _registeredDate = nil;
        _iconImage = nil;
        
        _containerURL = @"";
        _dataContainerURL = @"";
      
        _appStoreReceiptURL = @"";
        _storeFront = nil;
        _purchaserDSID = nil;
        
        _cacheGUID = nil;
        _uniqueIdentifier = nil;
        _machOUUIDs = nil;
        
        _installType = 0;
        _originalInstallType = 0;
        _sequenceNumber = 0;
        _appHash = 0;
        
        _foundBackingBundle = YES;
        
        _isAdHocCodeSigned = NO;
        _profileValidated = NO;
        _isInstalled = YES;
        _isRestricted = NO;
        
        _storeCohortMetadata = @"";
        _uiBackgroundModes = nil;
        _tags = nil;
        _companionAppIdentifier = @"";
    }
    
    return self;
}

//Override setter for store front
- (void)setStoreFront:(NSNumber *)storeFront
{
    _storeFront = storeFront;
    
    NSString *strStoreFront = [storeFront stringValue];
    if(strStoreFront)
    {
        _storeName = [storeFrontMapping valueForKey:strStoreFront];
        if(_storeName == nil)
        {
            _storeName = @"Unknown";
        }
    }
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
    else if([key isEqualToString:APP_BUNDLE_SIGNER_IDENTITY])
    {
        value = self.signerIdentity;
    }
    else if([key isEqualToString:APP_BUNDLE_EXECUTABLE])
    {
        value = self.bundleExecutable;
    }
    else if([key isEqualToString:APP_BUNDLE_ENTITLEMENTS])
    {
        value = self.entitlements;
    }
    else if([key isEqualToString:APP_BUNDLE_ENVIRONMENT_VARIABLES])
    {
        value = self.environmentVariables;
    }
    else if([key isEqualToString:APP_BUNDLE_URL])
    {
        value = self.bundleURL;
    }
    else if([key isEqualToString:APP_BUNDLE_CONTAINER_URL])
    {
        value = self.bundleContainerURL;
    }
    else if([key isEqualToString:APP_NAME])
    {
        value = self.name;
    }
    else if([key isEqualToString:APP_SHORT_NAME])
    {
        value = self.shortName;
    }
    else if([key isEqualToString:APP_TYPE])
    {
        value = self.type;
    }
    if([key isEqualToString:APP_TEAM_ID])
    {
        value = self.teamID;
    }
    else if([key isEqualToString:APP_VENDOR_NAME])
    {
        value = self.vendorName;
    }
    else if([key isEqualToString:APP_SOURCE_IDENTIFIER])
    {
        value = self.sourceAppIdentifier;
    }
    else if([key isEqualToString:APP_STORE_NAME])
    {
        value = self.storeName;
    }
    else if([key isEqualToString:APP_REGISTERED_DATE])
    {
        value = self.registeredDate;
    }
    else if([key isEqualToString:APP_CONTAINER_URL])
    {
        value = self.containerURL;
    }
    else if([key isEqualToString:APP_DATA_CONTAINER_URL])
    {
        value = self.dataContainerURL;
    }
    else if([key isEqualToString:APP_STORE_RECEIPT_URL])
    {
        value = self.appStoreReceiptURL;
    }
    else if([key isEqualToString:APP_STORE_FRONT])
    {
        value = self.storeFront;
    }
    else if([key isEqualToString:APP_PURCHASER_DSID])
    {
        value = self.purchaserDSID;
    }
    else if([key isEqualToString:APP_APPLICATION_DSID])
    {
        value = self.applicationDSID;
    }
    else if([key isEqualToString:APP_CACHE_GUID])
    {
        value = self.cacheGUID;
    }
    else if([key isEqualToString:APP_UNIQUE_IDENTIFIER])
    {
        value = self.uniqueIdentifier;
    }
    else if([key isEqualToString:APP_MACH_O_UUIDS])
    {
        value = self.machOUUIDs;
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
    else if([key isEqualToString:APP_SEQUENCE_NUMBER])
    {
        NSNumber *numSequenceNumber = [NSNumber numberWithUnsignedInt:self.sequenceNumber];
        value = numSequenceNumber;
    }
    else if([key isEqualToString:APP_HASH])
    {
        NSNumber *numAppHash = [NSNumber numberWithUnsignedInt:self.appHash];
        value = numAppHash;
    }
    if([key isEqualToString:APP_FOUND_BACKING_BUNDLE])
    {
        NSNumber *numFoundBackingBundle = [NSNumber numberWithBool:self.foundBackingBundle];
        value = numFoundBackingBundle;
    }
    if([key isEqualToString:APP_IS_ADHOC_CODE_SIGNED])
    {
        NSNumber *numIsAdHocCodeSigned = [NSNumber numberWithBool:self.isAdHocCodeSigned];
        value = numIsAdHocCodeSigned;
    }
    if([key isEqualToString:APP_PROFILE_VALIDATED])
    {
        NSNumber *numIsProfileValidated = [NSNumber numberWithBool:self.profileValidated];
        value = numIsProfileValidated;
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
    else if([key isEqualToString:APP_UI_BACKGROUND_MODES])
    {
        value = self.uiBackgroundModes;
    }
    else if([key isEqualToString:APP_TAGS])
    {
        value = self.tags;
    }
    if([key isEqualToString:APP_COMPANION_APP_IDENTIFIER])
    {
        value = self.companionAppIdentifier;
    }
    return value;
}

@end
