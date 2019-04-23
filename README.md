# Firebase Remote Config - Titanium Module

Use the native Firebase SDK in Axway Titanium. This repository is part of the [Titanium Firebase](https://github.com/hansemannn/titanium-firebase) project.

## Requirements

- [x] The [Firebase Core](https://github.com/hansemannn/titanium-firebase-core) module
- [x] Titanium SDK 7.0.0+

## Download

- [x] [Stable release](https://github.com/hansemannn/titanium-firebase-config/releases)
- [x] [![gitTio](http://hans-knoechel.de/shields/shield-gittio.svg)](http://gitt.io/component/firebase.config)

## Example Config Manager

```js
import TiFirebaseConfig from 'firebase.config';

export default class ConfigManager {
    
    static fetch () {
        TiFirebaseConfig.fetch({
            callback: event => {
                TiFirebaseConfig.activateFetched();
            }
        });
    }

    static getString(key) {
        const value = TiFirebaseConfig.configValueForKey(key);
        if (!value) return undefined;

        return value.string;
    }

    static getBool(key) {
        const value = TiFirebaseConfig.configValueForKey(key);
        if (!value) return undefined;

        return value.bool;
    }

    static getNumber(key) {
        const value = TiFirebaseConfig.configValueForKey(key);
        if (!value) return undefined;

        return value.number;
    }

    static getData(key) {
        const value = TiFirebaseConfig.configValueForKey(key);
        if (!value) return undefined;

        return value.data;
    }
}
```

## API's

### Cross Platform Methods

#### `activateFetched()` (iOS / Android)

#### `fetch(parameters)` (iOS / Android)
  - `parameters` (Dictionary)
    - `callback` (Function)
    - `expirationDuration` (Number, optional)

#### `configValueForKey(key, namespace) -> Dictionary` (iOS / Android)
  - `key` (String)
  - `namespace` (String, optional)

### iOS-only Methods

#### `objectForKeyedSubscript(keyedSubscript) -> Dictionary`
  - `keyedSubscript` (String)

#### `allKeysFromSource(source, namespace) -> Array<String>`
  - `source` (`SOURCE_`)
  - `namespace` (String, optional)

#### `keysWithPrefix(prefix, namespace) -> Array<String>`
  - `prefix` (String)
  - `namespace` (String, optional)

#### `setDefaults(defaults, namespace)`
  - `defaults` (Dictionary)
  - `namespace` (String, optional)

#### `setDefaultsFromPlist(plistName, namespace)`
  - `plistName` (Dictionary)
  - `namespace` (String, optional)

#### `defaultValueForKey(parameters) -> Dictionary`
  - `key` (String)
  - `namespace` (String, optional)

### iOS-only Properties

#### `lastFetchTime` (Date, get)

#### `lastFetchStatus` (`FETCH_STATUS_*`, get)

#### `developerModeEnabled` (Bool, get/set)

### iOS-only Constants

#### `FETCH_STATUS_NO_FETCH_YET`
#### `FETCH_STATUS_SUCCESS`
#### `FETCH_STATUS_FAILURE`
#### `FETCH_STATUS_THROTTLED`

#### `SOURCE_REMOTE`
#### `SOURCE_DEFAULT`
#### `SOURCE_STATIC`

## Build

```js
cd [ios|android]
appc run -p [ios|android] --build-only
```

## Legal

This module is Copyright (c) 2017-present by Hans Knöchel. All Rights Reserved. 
