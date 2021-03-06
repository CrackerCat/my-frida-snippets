#!/bin/sh

wget -q -O - https://api.github.com/repos/frida/frida/releases \
| jq '.[0] | .assets[] | select(.browser_download_url | match("frida-server-(.*)-android-arm64.xz")).browser_download_url' \
| xargs wget -q --show-progress $1 && unxz frida-server*
echo "[+] Download has completed."

adb push frida-server*-android-arm64 /data/local/tmp/frida-server
echo "[+] Frida server exists in /data/local/tmp/frida-server now"
adb shell "chmod 755 /data/local/tmp/frida-server"
adb shell "/data/local/tmp/frida-server &"
echo "[+] frida-server is running..."

