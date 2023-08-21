#!/usr/bin/env bash
### every exit != 0 fails the script
set -e
if [[ -n $DEBUG ]]; then
    verbose="-v"
fi

for var in "$@"
do
    echo "fix permissions for: $var"
    find "$var"/ -name '*.sh' -exec chmod $verbose a+x {} +
    find "$var"/ -name '*.desktop' -exec chmod $verbose a+x {} +
    chgrp -R 0 "$var" && chmod -R $verbose a+rw "$var" && find "$var" -type d -exec chmod $verbose a+x {} +
done
echo "-------------------------------INSTALL DROID------------------------"
echo "export ANDROID_SDK_ROOT=/opt/android-sdk" >> ~/.bashrc
echo "export ANDROID_HOME=/opt/android-sdk" >> ~/.bashrc
echo "export ANDROID_EMULATOR_WAIT_TIME_BEFORE_KILL=60" >> ~/.bashrc
echo "export ANDROID_AVD_HOME=/root/.android/avd/" >> ~/.bashrc
source ~/.bashrc

echo "y" | /opt/android-sdk/cmdline-tools/tools/bin/sdkmanager "platforms;android-24" "system-images;android-24;default;x86_64" "build-tools;24.0.1"
#echo "y" | /opt/android-sdk/cmdline-tools/tools/bin/sdkmanager "platforms;android-30" "system-images;android-30;google_apis_playstore;x86_64" "build-tools;30.0.2"
echo "y" | /opt/android-sdk/cmdline-tools/tools/bin/sdkmanager platform-tools emulator
#echo "no" | /opt/android-sdk/cmdline-tools/tools/bin/avdmanager create avd -n "my_avd_24" -k "system-images;android-24;default;x86_64"

#cd
#wget https://dl.google.com/android/repository/commandlinetools-linux-10406996_latest.zip
#unzip commandlinetools-linux-10406996_latest.zip
#mkdir cmdline-tools
#unzip commandlinetools-mac-8092744_latest.zip
#mv cmdline-tools latest
#mkdir sdk
#mkdir sdk/cmdline-tools
#mv latest sdk/cmdline-tools
#cd sdk/cmdline-tools/bin/
#./sdkmanager platform-tools emulator


