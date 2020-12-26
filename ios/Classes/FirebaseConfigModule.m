/**
 * titanium-firebase-config
 *
 * Created by Hans Knoechel
 * Copyright (c) 2020 by Hans Knöchel. All rights reserved.
 */

#import <FirebaseRemoteConfig/FirebaseRemoteConfig.h>

#import "FirebaseConfigModule.h"
#import "FirebaseConfigUtilities.h"

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

- (NSNumber *)activateFetched:(id)callback
{
  ENSURE_SINGLE_ARG_OR_NIL(callback, KrollCallback);

  [[FIRRemoteConfig remoteConfig] activateWithCompletion:^(BOOL changed, NSError * _Nullable error) {
    if (callback != nil) {
      NSMutableDictionary *event = [NSMutableDictionary dictionaryWithDictionary:@{ @"success": @(error == nil), @"changed": @(changed) }];
      if (error != nil) {
        event[@"error"] = error.localizedDescription;
      }

      [callback call:@[event] thisObject:self];
    }
  }];

  // TODO: Remove in next version, keep only for parity with Android
  return nil;
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
    NSLog(@"[ERROR] Namespaces are not used in Firebase Config anymore.");
    return nil;
  } else {
    NSLog(@"[ERROR] Unknown argument count provided");
  }
}

- (id)getString:(id)key
{
  ENSURE_SINGLE_ARG(key, NSString);
  return [FIRRemoteConfig.remoteConfig configValueForKey:key].stringValue;
}

- (id)getBool:(id)key
{
  ENSURE_SINGLE_ARG(key, NSString);
  return @([FIRRemoteConfig.remoteConfig configValueForKey:key].boolValue);
}

- (id)getNumber:(id)key
{
  ENSURE_SINGLE_ARG(key, NSString);
  return [FIRRemoteConfig.remoteConfig configValueForKey:key].numberValue;
}

- (id)getData:(id)key
{
  ENSURE_SINGLE_ARG(key, NSString);
  return [[TiBlob alloc] initWithData:[FIRRemoteConfig.remoteConfig configValueForKey:key].dataValue mimetype:@"text/plain"];
}

- (NSArray *)allKeysFromSource:(id)arguments
{
  NSString *source = [arguments objectAtIndex:0];
  NSString *namespace = [arguments objectAtIndex:1];

  if (namespace != nil) {
    NSLog(@"[ERROR] Namespaces are not used in Firebase Config anymore.");
  }

  return [[FIRRemoteConfig remoteConfig] allKeysFromSource:source.intValue];
}

- (NSArray *)keysWithPrefix:(id)arguments
{
  if ([arguments count] == 1) {
    ENSURE_SINGLE_ARG(arguments, NSString);
    return [[[FIRRemoteConfig remoteConfig] keysWithPrefix:arguments] allObjects];
  } else if ([arguments count] == 2) {
    NSLog(@"[ERROR] Namespaces are not used in Firebase Config anymore.");
    return nil;
  } else {
    NSLog(@"[ERROR] Unknown argument count provided");
  }
}

- (void)setDefaults:(id)arguments
{
  if ([arguments isKindOfClass:[NSDictionary class]]) {
    [[FIRRemoteConfig remoteConfig] setDefaults:arguments];
  } else if ([arguments isKindOfClass:[NSString class]]) {
    [[FIRRemoteConfig remoteConfig] setDefaultsFromPlistFileName:arguments];
  } else if ([arguments isKindOfClass:[NSArray class]]) {
    NSDictionary *defaults = [arguments objectAtIndex:0];
    NSString *namespace = [arguments objectAtIndex:1];
    if (namespace != nil) {
      NSLog(@"[ERROR] Namespaces are not used in Firebase Config anymore.");
    }
    [[FIRRemoteConfig remoteConfig] setDefaults:arguments];
  } else {
    [self throwException:@"Invalid defaults provided" subreason:@"Please either pass a dictionary or string" location:CODELOCATION];
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
    if (namespace != nil) {
      NSLog(@"[ERROR] Namespaces are not used in Firebase Config anymore.");
    }
    [[FIRRemoteConfig remoteConfig] setDefaultsFromPlistFileName:plist];
  } else {
    NSLog(@"[ERROR] Unknown argument count provided");
  }
}

- (NSDictionary *)defaultValueForKey:(NSArray<NSString *> *)arguments
{
  NSString *key = [arguments objectAtIndex:0];

  if (arguments.count > 1) {
    NSLog(@"[ERROR] Namespaces are not used in Firebase Config anymore.");
  }

  return [FirebaseConfigUtilities dictionaryFromConfigValue:[[FIRRemoteConfig remoteConfig] defaultValueForKey:key]];
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
