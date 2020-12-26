/**
 * titanium-firebase-config
 *
 * Created by Hans Knoechel
 * Copyright (c) 2020 by Hans Knöchel. All rights reserved.
 */

#import <TitaniumKit/TitaniumKit.h>

@interface FirebaseConfigModule : TiModule

@property (nonatomic, readonly, strong) NSDate *lastFetchTime;

@property (nonatomic, readonly, assign) NSNumber *lastFetchStatus;

@property (nonatomic, readwrite, assign) NSNumber *developerModeEnabled;

- (NSNumber *)activateFetched:(id)unused;

- (void)fetch:(id)arguments;

- (NSDictionary *)objectForKeyedSubscript:(id)keyedSubscript;

- (NSDictionary *)configValueForKey:(id)arguments;

- (id)getString:(id)key;

- (id)getBool:(id)key;

- (id)getNumber:(id)key;

- (id)getData:(id)key;

- (NSArray *)allKeysFromSource:(id)arguments;

- (NSArray *)keysWithPrefix:(id)arguments;

- (void)setDefaults:(id)arguments;

- (void)setDefaultsFromPlist:(id)arguments;

- (NSDictionary *)defaultValueForKey:(id)arguments;

@end
