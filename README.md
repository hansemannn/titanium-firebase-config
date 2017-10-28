# Firebase Remote Config - Titanium Module
Use the native Firebase SDK in Axway Titanium. This repository is part of the [Titanium Firebase](https://github.com/hansemannn/titanium-firebase) project.

## Requirements
- [x] Titanium SDK 6.2.0 or later

## API's

### `FirebaseConfig`

#### Methods

##### `activateFetched()`

##### `fetch(parameters)`
  - `parameters` (Dictionary)
    - `callback` (Function)
    - `expirationDuration` (Number, optional)

##### `objectForKeyedSubscript(keyedSubscript) -> Dictionary`
  - `keyedSubscript` (String)

##### `configValueForKey(key, namespace) -> Dictionary`
  - `key` (String)
  - `namespace` (String, optional)

##### `allKeysFromSource(source, namespace) -> Array<String>`
  - `source` (`SOURCE_`)
  - `namespace` (String, optional)

##### `keysWithPrefix(prefix, namespace) -> Array<String>`
  - `prefix` (String)
  - `namespace` (String, optional)

##### `setDefaults(defaults, namespace)`
  - `defaults` (Dictionary)
  - `namespace` (String, optional)

##### `setDefaultsFromPlist(plistName, namespace)`
  - `plistName` (Dictionary)
  - `namespace` (String, optional)

##### `defaultValueForKey(parameters) -> Dictionary`
  - `key` (String)
  - `namespace` (String, optional)

### Properties

#### `lastFetchTime` (Date, get)

#### `lastFetchStatus` (`FETCH_STATUS_*`, get)

#### `developerModeEnabled` (Bool, get/set)

### Constants

#### `FETCH_STATUS_NO_FETCH_YET`
#### `FETCH_STATUS_SUCCESS`
#### `FETCH_STATUS_FAILURE`
#### `FETCH_STATUS_THROTTLED`

#### `SOURCE_REMOTE`
#### `SOURCE_DEFAULT`
#### `SOURCE_STATIC`

## Example
```js
var FirebaseConfig = require('firebase.config');

// TBA
```

## Build
```js
cd ios
appc ti build -p ios --build-only
```

## Legal

This module is Copyright (c) 2017-present by Appcelerator, Inc. All Rights Reserved. 
Usage of this module is subject to the Terms of Service agreement with Appcelerator, Inc.  
