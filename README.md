# Read me

A new Flutter project.

## Important commands
- flutter pub deps
- flutter pub run change_app_package_name:main id.rnq.archeryclub
- flutter pub run flutter_launcher_icons:main
- ./gradlew signingReport

# Tutorial Deploy
- https://flutter.dev/docs/deployment/android
- keytool -exportcert -list -v -alias upload -keystore app/upload-keystore.jks
- adb shell 'am start -W -a android.intent.action.VIEW -c android.intent.category.BROWSABLE -d "unilinks://karirlink.id/path/portion/?uid=123&token=abc"'

# update pod repo di Mac M1
sudo arch -x86_64 gem install ffi
arch -x86_64 pod install
arch -x86_64 pod install --repo-update