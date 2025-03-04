#!/usr/bin/env bash
# Copyright (C) 2024 The Qt Company Ltd.
# SPDX-License-Identifier: LicenseRef-Qt-Commercial OR LGPL-3.0-only OR GPL-2.0-only OR GPL-3.0-only

# This script installs JDK

set -ex

echo "Installing Java Development Kit"

targetFile=zulu17.54.21-ca-jdk17.0.13-macosx_aarch64.dmg

url=ci-files01-hki.ci.qt.io:/hdd/www/input/mac
# url_alt=https://cdn.azul.com/zulu/bin/zulu17.54.21-ca-jdk17.0.13-macosx_aarch64.dmg

echo "Mounting $targetFile"
sudo mkdir -p /Volumes/files
sudo mount -o locallocks "$url" /Volumes/files

sudo cp "/Volumes/files/$targetFile" /tmp
sudo umount /Volumes/files
sudo hdiutil attach "/tmp/$targetFile"

echo Installing JDK
cd /Volumes/Azul\ Zulu\ JDK\ 17.54+21 && sudo installer -pkg Double-Click\ to\ Install\ Azul\ Zulu\ JDK\ 17.pkg -target /

echo "Unmounting $targetFile"
sudo hdiutil unmount /Volumes/Azul\ Zulu\ JDK\ 17.54+21 -force

echo "Disable auto update"
sudo defaults write /Library/Preferences/com.oracle.java.Java-Updater JavaAutoUpdateEnabled -bool false

echo "JDK Version = 17.0.13" >> ~/versions.txt
