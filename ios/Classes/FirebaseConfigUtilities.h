//
//  FirebaseConfigUtilities.h
//  titanium-firebase-config
//
//  Created by Hans Knöchel on 28.10.17.
//

#import <Foundation/Foundation.h>

@class FIRRemoteConfigValue;

@interface FirebaseConfigUtilities : NSObject

+ (NSDictionary *)dictionaryFromConfigValue:(FIRRemoteConfigValue *)configValue;

@end
