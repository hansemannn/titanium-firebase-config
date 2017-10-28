/**
 * titanium-firebase-config
 *
 * Created by Hans Knoechel
 * Copyright (c) 2017 Axway Appcelerator. All rights reserved.
 */

#import "FirebaseConfigModule.h"
#import "FirebaseConfigUtilities.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"
#import <FirebaseRemoteConfig/FirebaseRemoteConfig.h>

@implementation FirebaseConfigModule

#pragma mark Internal

- (id)moduleGUID
{
  return @"020977b2-c61c-4269-94c0-45cec7c2ab98";
}

- (NSString *)moduleId
{
  return @"firebase.config";
}

#pragma mark Lifecycle

- (void)startup
{
  [super startup];
  NSLog(@"[DEBUG] %@ loaded", self);
}

#pragma Public APIs

- (NSDate *)lastFetchTime
{
  return [[FIRRemoteConfig remoteConfig] lastFetchTime];
}

- (NSNumber *)lastFetchStatus
{
  return @([[FIRRemoteConfig remoteConfig] lastFetchStatus]);
}

- (NSNumber *)developerModeEnabled
{
  return @([[[FIRRemoteConfig remoteConfig] configSettings] isDeveloperModeEnabled]);
}

- (void)setDeveloperModeEnabled:(NSNumber *)developerModeEnabled
{
  [[FIRRemoteConfig remoteConfig] setConfigSettings:[[FIRRemoteConfigSettings alloc] initWithDeveloperModeEnabled:[TiUtils boolValue:developerModeEnabled]]];
}

- (void)activateFetched:(id)unused
{
  [[FIRRemoteConfig remoteConfig] activateFetched];
}

- (void)fetch:(id)arguments
{
  ENSURE_SINGLE_ARG(arguments, NSDictionary);

  KrollCallback *callback = [arguments objectForKey:@"callback"];
  NSNumber *expirationDuration = [arguments objectForKey:@"expirationDuration"];

  typedef void (^FetchCompletionHandler)(FIRRemoteConfigFetchStatus status, NSError *error);

  FetchCompletionHandler handler = ^(FIRRemoteConfigFetchStatus status, NSError *error) {
    if (error != nil) {
      [callback call:@[ @{
        @"success" : @NO,
        @"error" : error.localizedDescription
      }] thisObject:self];
      return;
    }

    [callback call:@[ @{
      @"success" : @YES,
      @"status" : @(status)
    }] thisObject:self];
  };

  if (expirationDuration != nil) {
    [[FIRRemoteConfig remoteConfig] fetchWithExpirationDuration:expirationDuration.doubleValue completionHandler:handler];
    return;
  }

  [[FIRRemoteConfig remoteConfig] fetchWithCompletionHandler:handler];
}

- (NSDictionary *)objectForKeyedSubscript:(id)keyedSubscript
{
  ENSURE_SINGLE_ARG(keyedSubscript, NSString);
  return [FirebaseConfigUtilities dictionaryFromConfigValue:[[FIRRemoteConfig remoteConfig] objectForKeyedSubscript:keyedSubscript]];
}

- (NSDictionary *)configValueForKey:(id)arguments
{
  if ([arguments count] == 1) {
    ENSURE_SINGLE_ARG(arguments, NSString);
    return [FirebaseConfigUtilities dictionaryFromConfigValue:[[FIRRemoteConfig remoteConfig] configValueForKey:arguments]];
  } else if ([arguments count] == 2) {
    NSString *key = [arguments objectAtIndex:0];
    NSString *namespace = [arguments objectAtIndex:1];
    return [FirebaseConfigUtilities dictionaryFromConfigValue:[[FIRRemoteConfig remoteConfig] configValueForKey:key namespace:namespace]];
  } else {
    NSLog(@"[ERROR] Unknown argument count provided");
  }
}

- (NSArray *)allKeysFromSource:(id)arguments
{
  NSString *source = [arguments objectAtIndex:0];
  NSString *namespace = [arguments objectAtIndex:1];
  return [[FIRRemoteConfig remoteConfig] allKeysFromSource:source.intValue namespace:namespace];
}

- (NSArray *)keysWithPrefix:(id)arguments
{
  if ([arguments count] == 1) {
    ENSURE_SINGLE_ARG(arguments, NSString);
    return [[[FIRRemoteConfig remoteConfig] keysWithPrefix:arguments] allObjects];
  } else if ([arguments count] == 2) {
    NSString *prefix = [arguments objectAtIndex:0];
    NSString *namespace = [arguments objectAtIndex:1];
    return [[[FIRRemoteConfig remoteConfig] keysWithPrefix:prefix namespace:namespace] allObjects];
  } else {
    NSLog(@"[ERROR] Unknown argument count provided");
  }
}

- (void)setDefaults:(id)arguments
{
  if ([arguments count] == 1) {
    ENSURE_SINGLE_ARG(arguments, NSDictionary);
    [[FIRRemoteConfig remoteConfig] setDefaults:arguments];
  } else if ([arguments count] == 2) {
    NSDictionary *defaults = [arguments objectAtIndex:0];
    NSString *namespace = [arguments objectAtIndex:1];
    [[FIRRemoteConfig remoteConfig] setDefaults:arguments namespace:namespace];
  } else {
    NSLog(@"[ERROR] Unknown argument count provided");
  }
}

- (void)setDefaultsFromPlist:(id)arguments
{
  if ([arguments count] == 1) {
    ENSURE_SINGLE_ARG(arguments, NSString);
    [[FIRRemoteConfig remoteConfig] setDefaultsFromPlistFileName:arguments];
  } else if ([arguments count] == 2) {
    NSString *plist = [arguments objectAtIndex:0];
    NSString *namespace = [arguments objectAtIndex:1];
    [[FIRRemoteConfig remoteConfig] setDefaultsFromPlistFileName:plist namespace:namespace];
  } else {
    NSLog(@"[ERROR] Unknown argument count provided");
  }
}

- (NSDictionary *)defaultValueForKey:(id)arguments
{
  NSString *key = [arguments objectAtIndex:0];
  NSString *namespace = [arguments objectAtIndex:1];
  return [FirebaseConfigUtilities dictionaryFromConfigValue:[[FIRRemoteConfig remoteConfig] defaultValueForKey:key namespace:namespace]];
}

#pragma mark Constants

MAKE_SYSTEM_PROP(FETCH_STATUS_NO_FETCH_YET, FIRRemoteConfigFetchStatusNoFetchYet);
MAKE_SYSTEM_PROP(FETCH_STATUS_SUCCESS, FIRRemoteConfigFetchStatusSuccess);
MAKE_SYSTEM_PROP(FETCH_STATUS_FAILURE, FIRRemoteConfigFetchStatusFailure);
MAKE_SYSTEM_PROP(FETCH_STATUS_THROTTLED, FIRRemoteConfigFetchStatusThrottled);

MAKE_SYSTEM_PROP(SOURCE_REMOTE, FIRRemoteConfigSourceRemote);
MAKE_SYSTEM_PROP(SOURCE_DEFAULT, FIRRemoteConfigSourceDefault);
MAKE_SYSTEM_PROP(SOURCE_STATIC, FIRRemoteConfigSourceStatic);

@end
