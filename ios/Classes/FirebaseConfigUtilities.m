/**
 * titanium-firebase-config
 *
 * Created by Hans Knoechel
 * Copyright (c) 2020 by Hans Knöchel. All rights reserved.
 */

#import "FirebaseConfigUtilities.h"
#import "TiBlob.h"
#import <FirebaseRemoteConfig/FirebaseRemoteConfig.h>

@implementation FirebaseConfigUtilities

+ (NSDictionary *)dictionaryFromConfigValue:(FIRRemoteConfigValue *)configValue
{
  NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:@{ @"source" : @(configValue.source),
    @"bool" : @(configValue.boolValue) }];

  if (configValue.stringValue != nil) {
    result[@"string"] = configValue.stringValue;
  }

  if (configValue.numberValue != nil) {
    result[@"number"] = configValue.numberValue;
  }

  if (configValue.dataValue != nil) {
    result[@"data"] = [[TiBlob alloc] initWithData:configValue.dataValue mimetype:@"text/plain"];
  }

  return result;
}

@end
