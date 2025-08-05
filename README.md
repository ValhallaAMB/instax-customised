# instax

Just an updated version of the original creator's project with slight improvements

## Set up

- Have VSCode or any other scriptable text editors installed
- Install Flutter and Dart along side their extensions
- Install Android Studio for Device Emulation
- Create a Firebase project on Firebase Console and then create an android app
- Open the project inside of VSCode and run `flutter pub get`
- Link the device emulator to VSCode and run the app
- Boom! The app should compline and run on the emulator. Congrats!
  > Resources:
  >
  > - [Flutter get-started](https://docs.flutter.dev/get-started/install)
  > - [Flutter install](https://docs.flutter.dev/install)

## My changes

1. Updated all of the dependencies inside of `pubspec.yaml`
2. Changed the functionality inside of `user_package`, where I convert an image to base64 and save it as a string inside of the Firestore database instead of using Firestore storage.
3. Added comments to sections that need explanation.
4. Reorganized the folder structure of the project into a feature-folder structure.
5. Added Firebase configurations for Android.
6. Made all of the packages' models, entities usages across the app more consistent and up to standards.
7. Implemented automatic post refresh when user profile pictures are updated or new posts are created.
8. Added pull-to-refresh functionality for manual post updates.

## How did I update the repository

1. Updated all of the dependencies in all `pubspec.yaml` files
2. Deleted both the `android` and `ios` folders and then ran `flutter create .` in the terminal.
3. Changed the `ndkVersion` to the LTS version and `minSDK` depending on the dependencies requirement inside of `android/app/build.gradle.kts`.
4. Added the Firebase configuration.
   > Note
   >
   > You can find the Firebase configuration inside of `android/build.gradle.kts` and `android/app/build.gradle.kts`. Do NOT forget to add your `google-services.json` file in `android/app`
5. Added the consistencies and features that's mentioned above

## Necessary changes

To use image cropper on android you must make a few changes within the `android` folder in order for it to work.
For this project I had to follow the migration steps in order for it to work correctly. More detail [here](https://pub.dev/packages/image_cropper).

> 📘Info
>
> The `AndroidManifest` that they mention in their documentation is located in `android/app/src/main/AndroidManifest.xml`

## Debug console errors

This was an error that've encountered and thankfully found a solution on Flutter's issues [How Recompile with -Xlint:deprecation for details. #147414](https://github.com/flutter/flutter/issues/147414#issuecomment-2080012991)
**Error**:

```bash
Note: Some input files use or override a deprecated API.
Note: Recompile with -Xlint:deprecation for details.
warning: [options] source value 8 is obsolete and will be removed in a future release
warning: [options] target value 8 is obsolete and will be removed in a future release
warning: [options] To suppress warnings about obsolete options, use -Xlint:-options.
```

**Solution**: Adding this piece of code to `android/build.gradle.kts`

```kotlin
subprojects.forEach { project ->
    logger.quiet("Updating settings for project ${project}")
    project.tasks.withType<JavaCompile> {
        options.compilerArgs.addAll(listOf("-Xlint:deprecation"))
    }
}
```
