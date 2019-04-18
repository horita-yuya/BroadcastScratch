# BroadcastScratch
Sample of VideoCast-Swift and HaishinKit.

## Preparation

### Overview
![Overview](Resources/overview.png)

### Steps

#### 1 Install [local rtmp server tool](https://github.com/sallar/mac-local-rtmp-server).

<img src='Resources/mac-rtmp-icon.png' width=100>

#### 2 Install [VLC Player](https://www.videolan.org/vlc/download-macosx.html).

<img src='Resources/vlc.png' width=100>

#### 3 Build this project, setting your local rtmp server ip address. In my case,
```Swift
struct Config {
    private static let ip: String = "172.22.179.179"
    static let streamUrl: String = "rtmp://\(ip)/live"
    static let streamKey: String = "BJHW9L9LE"
}
```

#### 4 Launch local rtmp server and start broadcasting using VideoCast-Swift or HaishinKit.

**Not connecting status**

<img src='Resources/waiting.png' width=300>

**Connecting status**

<img src='Resources/connecting.png' width=300>

#### 5 Play via VLC

<img src='Resources/play.png' width=300>

## Setup
```
bundle install
bundle exec pod install
```
