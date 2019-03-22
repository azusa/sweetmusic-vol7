# App Centerからのアプリ配布

## In App Update

- 条件: Release Buildであること
- バ ージョンがあがっていること
- Microsoft.AppCenter.Distributeが組み込まれていること

https://docs.microsoft.com/en-us/appcenter/distribution/inappupdates


Androidアプリケーションの場合は、`AndroidManifest.xml`で`versionCode`ないし`versionName`がインクリメントされていること

- a higher value of versionCode or
- an equal value of versionCode but a higher value of versionName.

iOSアプリケーションの場合は、`Info.plist`で`CFBundleShortVersionString`ないし`CFBundleVersion`がインクリメントされていること

- a higher value of CFBundleShortVersionString or
- an equal value of CFBundleShortVersionString but a higher value of CFBundleVersion.

iOSアプリケーションの場合は、`Info.plist`に
`CFBundleURLSchemes`の項目が追加されている必要があります。

App Centerでは、ビルドの設定の「Automatically increment version code」の
チェックを有効にすることで、AndroidアプリケーションおよびiOSアプリケーションの
ビルド時にこれらのバージョンを自動でインクリメントすることができます。

```
  <array>
      <dict>
          <key>CFBundleURLSchemes</key>
          <array>
              <string>appcenter-(iOSアプリケーションのシークレット)</string>
          </array>
      </dict>
  </array>
```  


## アプリ内のパーミッション許可

Android8.0(Oreo)から、Play Storeを経由しないで配布されているアプリケーション<span class="footnote">いわゆる野良アプリ</span>のインストールへの許可は、
APKファイルをダウンロードするアプリケーションごとに行うようになりました。

App CenterからインストールするAndroidアプリケーションの、アプリ内更新を有効にするには、
「不明なアプリのインストール」内の、「この提供元のアプリを許可」の設定を有効にする必要があります。

iOSアプリケーションの場合は、ビルドする際に指定するProvisioning Profileの対象に、
アプリ内更新でインストールする端末が含まれている必要があります。



## HockeyAppからのマイグレーション



```
AppCenter.LogLevel = LogLevel.Verbose;
```

```
デフォルト	00:14:02.829143 +0900	SpringBoard	Deactivated alertItem: <SBUserNotificationAlert: 0x10ee19f90; title: “CalendarViewer”がサインインのために“appcenter.ms”を使用しようとしています。; source: SafariViewService; pid: 4776>
デフォルト	00:14:03.123013 +0900	com.apple.WebKit.Networking	[C1 Hostname#fe80108d:443 tcp, bundle id: com.apple.mobilesafari, url: https://install.appcenter.ms/apps/(ios app secret)/update-setup?release_hash=4fe7803032ed003fa2ee5c2, tls] start
デフォルト	00:14:04.498500 +0900	SafariViewService	Application jp.co.gxp.experiment.honaka.CalendarViewer is able to handle scheme appcenter-(ios app secret) for authentication
デフォルト	00:14:04.506117 +0900	CalendarViewer.iOS	[AppCenterDistribute] ERROR: -[MSDistribute openURL:]/1082 Cannot find either update token or distribution group id.
デフォルト	00:14:04.506200 +0900	CalendarViewer.iOS	[AppCenterDistribute] DEBUG: -[MSDistribute openURL:]/1098 In-app updates setup failure detected.
デフォルト	00:14:30.185039 +0900	CalendarViewer.iOS	[C1 Hostname#bfc8d1f8:443 tcp, url: https://in.appcenter.ms/logs?api-version=1.0.0, tls] cancel
デフォルト	00:14:30.185240 +0900	CalendarViewer.iOS	[C1 Hostname#bfc8d1f8:443 tcp, url: https://in.appcenter.ms/logs?api-version=1.0.0, tls] cancelled
	[C1.1 <private> 192.168.10.4:56846<->IPv4#b59aae0a:443]
	Connected Path: satisfied (Path is satisfied), interface: en0, ipv4, ipv6, dns
	Duration: 31.323s, DNS @0.000s took 0.024s, TCP @0.028s took 0.155s, TLS took 0.347s
	bytes in/out: 5688/1325, packets in/out: 6/4, rtt: 0.159s, retransmitted packets: 0, out-of-order packets: 0
デフォルト	00:14:30.187526 +0900	CalendarViewer.iOS	[C2 Hostname#bfc8d1f8:443 tcp, url: https://in.appcenter.ms/logs?api-version=1.0.0, tls] cancel
デフォルト	00:14:30.187617 +0900	CalendarViewer.iOS	[C2 Hostname#bfc8d1f8:443 tcp, url: https://in.appcenter.ms/logs?api-version=1.0.0, tls] cancelled
	[C2.1 <private> 192.168.10.4:56847<->IPv4#b59aae0a:443]
	Connected Path: satisfied (Path is satisfied), interface: en0, ipv4, ipv6, dns
	Duration: 30.788s, DNS @0.000s took 0.005s, TCP @0.008s took 0.154s, TLS took 0.339s
	bytes in/out: 5688/1304, packets in/out: 6/4, rtt: 0.158s, retransmitted packets: 0, out-of-order packets: 0
```
