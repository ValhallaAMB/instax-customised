# instax

Just an updated version of the original creator's project with slight improvements 

## My changes

1. Updated all of the dependencies inside of `pubspec.yaml`
2. Changed the functionality inside of `user_package`, where I convert an image to base64 and save it as a string inside of the Firestore database instead of using Firestore storage.
3. Added comments to sections that need explanation.
4. Reorganized the folder structure of the project into a feature-folder structure.
5. Added Firebase configurations for Android.
6. Made all of the packages' models, entities usages across the app more consistent and up to standards.  

## Necessary changes

To use image cropper on android you must add this piece of code inside of `android/app/src/main/AndroidManifest.xml` in order for it to work.

```xml
<activity
    android:name="com.yalantis.ucrop.UCropActivity"
    android:screenOrientation="portrait"
    android:theme="@style/Theme.AppCompat.Light.NoActionBar"/>
```

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
