## 「Build frequency」


## ブランチが増えた時の挙動

Gitのリモートリポジトリーに新しいブランチをpushすると、
「Build」に新しいブランチが作成されます。

このブランチの右側の「Settings」を選択し、
ビルドに必要な設定を行った上で「Save and Build」を、初回のビルドが実行されます。

## API Keyなどの管理の方法～コード書き換え



- https://qiita.com/amay077/items/aac34280feefd7a1db8c
- http://shimbaroid.hatenablog.jp/entry/2016/08/15/010350

## AndroidManifestPlaceholdersによるビルド時の環境変数の書き換え

AndroidやiOSなどのプラットフォームでのアプリケーション開発では、APKファイルやIPAファイルを逆アセンブルすると
アプリケーション内の情報は解読できてしまうため、秘匿したい情報をコードから隠蔽することに積極的な意味はありません。

App Centerのチュートリアルでも、App CenterのSDKを起動するためのSecret Keyは、
Androidアプリケーションにおける`MainActivity.cs`の`OnCreate`メソッドやiOSアプリケーションにおける`AppDelegate.cs`の`FinishedLaunching`メソッドなど、ソースコードに埋め込むようになっています。

しかし、ソースコードを公開している場合や、外部の業者に開発を委託する場合など、
ソースコード中にキーを埋め込みたくない場合があります。

Androidには、AndroidManifest.xmlに記述したメタデータの値をアプリケーション内で取得する仕組みがあります。

- http://www.raghurana.com/building-and-deploying-apps-using-vsts-and-hockeyapp-part-2nbsp-android
- https://github.com/xamarin/xamarin-android/pull/342


