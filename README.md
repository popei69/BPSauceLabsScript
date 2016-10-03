# BPSauceLabsScript
A Xcode friendly shell script to automate upload to SauceLabs Storage.

### Installion

To be able to automatically upload your app to SauceLabs services, copy this script file at the root of your XCode project. Then add a run script phase to your target project

```sh
SCRIPT=`/usr/bin/find "${SRCROOT}" -name upload-ios-app-to-saucelabs.sh | head -n 1`
 
if [ "${CONFIGURATION}" = "Debug" ]
then
echo "[info] Build for Debug ${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app"
/bin/sh "${SCRIPT}" "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app" "MY_SAUCELAB_USERNAME" "MY_ACCESS_KEY"
```

This script is related to an UI automation testing blog here : https://benoitpasquier.fr/xcode-saucelabs/

With love.
