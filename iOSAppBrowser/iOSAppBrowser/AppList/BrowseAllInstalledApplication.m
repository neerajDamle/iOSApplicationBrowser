//
//  BrowseAllInstalledApplication.m
//  iosAsst
//
//  Created by peter_peng on 14-10-10.
//  Copyright (c) 2014年 www.iphonezs.com. All rights reserved.
//

#import "BrowseAllInstalledApplication.h"
#import <dlfcn.h>
#include <objc/runtime.h>

#import <UIKit/UIImage.h>

/*
 @param format
 0 - 29x29
 1 - 40x40
 2 - 62x62
 3 - 42x42
 4 - 37x48
 5 - 37x48
 6 - 82x82
 7 - 62x62
 8 - 20x20
 9 - 37x48
 10 - 37x48
 11 - 122x122
 12 - 58x58
 */

@interface UIImage (UIApplicationIconPrivate)
+ (id)_iconForResourceProxy:(id)arg1 format:(int)arg2;
+ (id)_iconForResourceProxy:(id)arg1 variant:(int)arg2 variantsScale:(float)arg3;
+ (id)_applicationIconImageForBundleIdentifier:(id)arg1 roleIdentifier:(id)arg2 format:(int)arg3 scale:(float)arg4;
+ (id)_applicationIconImageForBundleIdentifier:(id)arg1 roleIdentifier:(id)arg2 format:(int)arg3;
+ (id)_applicationIconImageForBundleIdentifier:(id)arg1 format:(int)arg2 scale:(float)arg3;
+ (id)_applicationIconImageForBundleIdentifier:(id)arg1 format:(int)arg2;
+ (int)_iconVariantForUIApplicationIconFormat:(int)arg1 scale:(float *)arg2;
- (id)_applicationIconImageForFormat:(int)arg1 precomposed:(BOOL)arg2 scale:(float)arg3;
- (id)_applicationIconImageForFormat:(int)arg1 precomposed:(BOOL)arg2;
@end





@implementation BrowseAllInstalledApplication

typedef NSDictionary* (*MobileInstallationLookup)(NSDictionary* params, id callback_unknown_usage);
NSMutableArray* browseInstalledAppListForIos7()
{
    const char *path="/System/Library/PrivateFrameworks/MobileInstallation.framework/MobileInstallation";
    void* lib = dlopen(path, RTLD_LAZY);
    if (lib) {
        MobileInstallationLookup sMobileInstallationLookup = (MobileInstallationLookup)dlsym(lib, "MobileInstallationLookup");
        if (sMobileInstallationLookup) {
            
            NSDictionary* params = [NSDictionary dictionaryWithObject:@"User"
                                                               forKey:@"ApplicationType"];
            NSMutableArray* appList = [NSMutableArray array];
            NSDictionary* dict = sMobileInstallationLookup(params, NULL);
            NSArray* allkeys = [dict allKeys];
            
            for (NSString *key in allkeys) {
                
                NSDictionary* value = [dict objectForKey:key];
                NSString* bundleVersion = [value objectForKey:@"CFBundleVersion"];
                NSString* bundleShortVersion = [value objectForKey:@"CFBundleShortVersionString"];
                NSString* bundleDisplayName = [value objectForKey:@"CFBundleDisplayName"];
                if (bundleVersion == nil) {
                    bundleVersion = @"1.0";
                }
                if (bundleShortVersion == nil) {
                    bundleShortVersion = @"1.0";
                }
                
                if (bundleDisplayName == nil) {
                    bundleDisplayName = @"Unknown";
                }

                NSDictionary* appDictionary = @{
                                                 @"bundleid" : key,
                                                 @"bundleShortVersion" : bundleShortVersion,
                                                 @"bundleVersion" : bundleVersion,
                                                 @"appName" : bundleDisplayName
                                                 };
                
                [appList addObject:appDictionary];
            }
            return appList;
        }
    }
    return nil;
}

+ (NSMutableArray *)browseInstalledAppListForIos8{
    
    Class LSApplicationWorkspace_class = objc_getClass("LSApplicationWorkspace");
    NSObject* workspace = [LSApplicationWorkspace_class performSelector:@selector(defaultWorkspace)];
    NSArray *list=[workspace performSelector:@selector(allInstalledApplications)];
    
    NSMutableArray* appList = [NSMutableArray array];
    
    for (id object in list) {
        
        NSString *shortVersion=[object performSelector:@selector(shortVersionString)];
//        NSString *msVersion=[object performSelector:@selector(minimumSystemVersion)];
        NSString *bundleVersion=[object performSelector:@selector(bundleVersion)];
        NSString *appIdentifier=[object performSelector:@selector(applicationIdentifier)];
        NSString *appType=[object performSelector:@selector(applicationType)];
        NSString *localizedName=[object performSelector:@selector(localizedName)];
        NSString *localizedShortName=[object performSelector:@selector(localizedShortName)];
//        NSNumber *staticDiskUsage=[object performSelector:@selector(staticDiskUsage)];
//        NSString *resourcesDirectoryURL=[object performSelector:@selector(resourcesDirectoryURL)];
        
        NSString *teamID = [object performSelector:@selector(teamID)];
        if(teamID == nil)
        {
            teamID = @"NA";
        }
        
        NSString *vendorName = [object performSelector:@selector(vendorName)];
        if(vendorName == nil)
        {
            vendorName = @"NA";
        }
        
        unsigned long long installType = [object performSelector:@selector(installType)];
        NSString *strInstallType = [NSString stringWithFormat:@"%llu",installType];
        if(strInstallType == nil)
        {
            strInstallType = @"NA";
        }
        
        unsigned long long originalInstallType = [object performSelector:@selector(originalInstallType)];
        NSString *strOriginalInstallType = [NSString stringWithFormat:@"%llu",originalInstallType];
        if(strOriginalInstallType == nil)
        {
            strOriginalInstallType = @"NA";
        }
        
        BOOL isProfileValidated = [object performSelector:@selector(profileValidated)];
        NSString *strIsProfileValidated = [NSString stringWithFormat:@"%@",isProfileValidated ? @"YES" : @"NO"];
        
        BOOL isInstalled = [object performSelector:@selector(isInstalled)];
        NSString *strIsInstalled = [NSString stringWithFormat:@"%@",isInstalled ? @"YES" : @"NO"];
        
        BOOL isRestricted = [object performSelector:@selector(isRestricted)];
        NSString *strIsRestricted = [NSString stringWithFormat:@"%@",isRestricted ? @"YES" : @"NO"];
        
        NSString *sourceAppIdentifier = [object performSelector:@selector(sourceAppIdentifier)];
        if(sourceAppIdentifier == nil)
        {
            sourceAppIdentifier = @"NA";
        }
        
        NSString *storeCohortMetadata = [object performSelector:@selector(storeCohortMetadata)];
        if(storeCohortMetadata == nil)
        {
            storeCohortMetadata = @"NA";
        }
        
        NSArray *appTags = [object performSelector:@selector(appTags)];
        if((appTags == nil) || (appTags.count == 0))
        {
            appTags = @[@"No tags"];
//            NSLog(@"App tags are nil for \"%@\"",appIdentifier);
        }
        else
        {
//            NSLog(@"App tags for \"%@\": %@",appIdentifier,appTags);
        }
        
        if ([appType isEqualToString:@"User"]) {
            
            NSString *appName;
            if (localizedName==nil) {
                if (localizedShortName==nil) {
                    appName=@"Unknown";
                }else{
                    appName =localizedName;
                }
            }else{
                appName=localizedName;
            }
            
            if (bundleVersion == nil) {
                bundleVersion = @"1.0";
            }
            if (shortVersion == nil) {
                shortVersion = @"1.0";
            }
           
            NSDictionary* appDictionary = @{
                                            @"bundleid" : appIdentifier,
                                            @"bundleShortVersion" : shortVersion,
                                            @"bundleVersion" : bundleVersion,
                                            @"appName" : localizedName,
                                            @"teamID" : teamID,
                                            @"vendorName" : vendorName,
                                            @"installType" : strInstallType,
                                            @"originalInstallType" : strOriginalInstallType,
                                            @"profileValidated" : strIsProfileValidated,
                                            @"isInstalled" : strIsInstalled,
                                            @"isRestricted" : strIsRestricted,
                                            @"sourceAppIdentifier" : sourceAppIdentifier,
                                            @"storeCohortMetadata" : storeCohortMetadata,
                                            @"appTags" : appTags
                                            };
            
            [appList addObject:appDictionary];
        }
    }
    return appList;
}

#pragma mark- 
#pragma mark- get all installed app
+ (NSMutableArray *)browseInstalledAppList{
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        return [self browseInstalledAppListForIos8];
    }else{
        return browseInstalledAppListForIos7();
    }
}
#pragma mark
#pragma mark- get installed app icon with identifier image default size 122x122
+ (UIImage *)appIconImageForBundleIdentifier:(NSString *)bundleId {
    
    UIImage* iconImage = [UIImage _applicationIconImageForBundleIdentifier:bundleId format:11 scale:[UIScreen mainScreen].scale];
    return iconImage;
}
@end
