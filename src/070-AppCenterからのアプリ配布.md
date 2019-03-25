# App Centerからのアプリ配布

## Disribute

- (Androidの場合)ダウンロードするブラウザーからのインストールが許可されていること
- Release Buildであること

## In App Update

- 条件: Release Buildであること
- バージョンがあがっていること
- Microsoft.AppCenter.Distributeが組み込まれていること
- プロファイルがインストールされていること(iOS)


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



