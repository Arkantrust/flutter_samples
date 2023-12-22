# contacts_app

This flutter mobile app shows how to use the `fast_contacts` package.

## Usage

Fisrt, add the `fast_contacts` and `permission_handler` packages to your `pubspec.yaml` file:

``` yaml
dependencies:
  flutter:
    sdk: flutter
  fast_contacts: ^3.1.2
  permission_handler: ^11.1.0
```

Add permissions to your [`AndroidManifest.xml`](android/app/src/main/AndroidManifest.xml) file:

``` xml
<uses-permission android:name="android.permission.READ_CONTACTS" />
```

Add permissions to your [`Info.plist`](ios/Runner/Info.plist) file:

``` plist
<key>NSContactsUsageDescription</key>  
	<string>Description of why you need the contacts permission.</string>
```


## Example

Example available at the [`lib`](lib/) folder.