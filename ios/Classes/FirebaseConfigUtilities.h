/**
 * titanium-firebase-config
 *
 * Created by Hans Knoechel
 * Copyright (c) 2020 by Hans Knöchel. All rights reserved.
 */

#import <Foundation/Foundation.h>

@class FIRRemoteConfigValue;

@interface FirebaseConfigUtilities : NSObject

+ (NSDictionary *)dictionaryFromConfigValue:(FIRRemoteConfigValue *)configValue;

@end
