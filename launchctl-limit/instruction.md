# Setup guide for the persistent limit of `launchctl` (for macOS)

> `launchctl limit` is a command in the launchctl tool used to display or set resource limits for processes managed by launchd.

## Check current `launchctl` Resource limit

```bash
launchctl limit
```

## Temporary change the limit (reset on reboot)

```bash
# example to increase the maxfiles
# 50000: soft limit, 200000: hard limit
# sudo is required along with password
sudo launchctl limit maxfiles 50000 200000
```

## Persist changing the limit (persist on reboot)

1. go to `LaunchDaemons`

```bash
cd /Library/LaunchDaemons
```

2. create a setting file

```bash
# /Library/LuanchDaemons/limit.maxfiles.plist
sudo touch limit.maxfiles.plist
```

3. Add the config

> [For more info](https://gist.github.com/tombigel/d503800a282fcadbee14b537735d202c)

```vim
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
  <plist version="1.0">
    <dict>
      <key>Label</key>
        <string>limit.maxfiles</string>
      <key>ProgramArguments</key>
        <array>
          <string>launchctl</string>
          <string>limit</string>
          <string>maxfiles</string>
          <string>50000</string>
          <string>200000</string>
        </array>
      <key>RunAtLoad</key>
        <true/>
      <key>ServiceIPC</key>
        <false/>
    </dict>
  </plist>
```

4. Save and restart the device.
