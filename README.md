# Firebase Remote Config - Titanium Module

Use the native Firebase SDK in Axway Titanium. This repository is part of the [Titanium Firebase](https://github.com/hansemannn/titanium-firebase) project.

## Requirements

- [x] The [Firebase Core](https://github.com/hansemannn/titanium-firebase-core) module
- [x] Titanium SDK 6.3.0+

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

## Build

```js
cd ios
appc run -p ios --build-only
```

## Legal

This module is Copyright (c) 2017-present by Hans Knöchel. All Rights Reserved. 
