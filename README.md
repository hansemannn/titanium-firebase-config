# Firebase Remote Config - Titanium Module

Use the native Firebase SDK in Axway Titanium. This repository is part of the [Titanium Firebase](https://github.com/hansemannn/titanium-firebase) project.

## Supporting this effort

The whole Firebase support in Titanium is developed and maintained by the community (`@hansemannn` and `@m1ga`). To keep
this project maintained and be able to use the latest Firebase SDK's, please see the "Sponsor" button of this repository,
thank you!

## Requirements

- [x] The [Firebase Core](https://github.com/hansemannn/titanium-firebase-core) module
- [x] Titanium SDK 10.0.0+

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
                TiFirebaseConfig.activateFetched(); // Activate the fetched values
            }
        });
    }

    static getString(key) {
      return TiFirebaseConfig.getString(key);
    }

    static getBool(key) {
      return TiFirebaseConfig.getBool(key);
    }

    static getNumber(key) {
      return TiFirebaseConfig.getNumber(key);
    }
}
```

## API's

### Methods

#### `fetchAndActivate(callback)` (iOS / Android)
  - `callback` (Function)

#### `setMinimumFetchIntervalInSeconds(minimumFetchInterval)` (iOS / Android)
  - `minimumFetchInterval` (Number)

#### `activateFetched()` (iOS / Android)

#### `fetch(parameters)` (iOS / Android)
  - `parameters` (Dictionary)
    - `callback` (Function)
    - `expirationDuration` (Number, optional)

#### `configValueForKey(key, namespace) -> Dictionary` (iOS / Android)
  - `key` (String)
  - `namespace` (String, optional)

#### `getString(key)` -> String //Use for JSON too
  - `key` (String)

#### `getBool(key)` -> String
  - `key` (String)

#### `getNumber(key)` -> String
  - `key` (String)

### Properties

#### `enableRealtimeUpdates(value: Boolean)`

Start listening for real-time config updates from the Remote Config backend and automatically
fetch updates when they're available. The result can be listened to via the `update` event.

If a connection to the Remote Config backend is not already open, calling this method will
open it. Multiple listeners can be added by calling this method again, but subsequent calls
re-use the same connection to the backend.

Note: Real-time Remote Config requires the Firebase Remote Config Realtime API. See Get started
with Firebase Remote Config at https://firebase.google.com/docs/remote-config/get-started for
more information.

### Events

#### `update`
  - `keys` (Array<String>) The updated keys.
Fired when a real time config update occurs.

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

#### `getData(key)` -> String
  - `key` (String)

### iOS-only Properties

#### `lastFetchTime` (Date, get)

#### `lastFetchStatus` (`FETCH_STATUS_*`, get)

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
