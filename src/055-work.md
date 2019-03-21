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

App Centerのドキュメント<span class="footnote">[https://docs.microsoft.com/en-us/appcenter/sdk/getting-started/xamarin](https://docs.microsoft.com/en-us/appcenter/sdk/getting-started/xamarin)</span>でも、App CenterのSDKを起動するためのSecret Keyは、
Androidアプリケーションにおける`MainActivity.cs`の`OnCreate`メソッドやiOSアプリケーションにおける`AppDelegate.cs`の`FinishedLaunching`メソッドなど、ソースコードに埋め込むようになっています。

しかし、ソースコードを公開している場合や、外部の業者に開発を委託する場合など、
ソースコード中にキーを埋め込みたくない場合があります。

Androidには、`AndroidManifest.xml` に記述したメタデータの値をアプリケーション内で取得する仕組みがあります。

また、 `AndroidManifest.xml`内に`$`というプレースホルダーではじまるパラメータを記述することで、ビルドプロセスのシステムプロパティ等に設定した値を、`AndroidManifest.xml`に注入することができます。

Xamarin.FormsのAndroidプロジェクトでは、Androidプロジェクトの`.csproj`にplaceholderに注入する値を記述し、ビルド時の環境変数からこの値を設定することで、ビルド時に`AndroidManifest.xml`に値を設定し、アプリケーションから取得することができます。<span class="footnote">[https://github.com/xamarin/xamarin-android/pull/342](https://github.com/xamarin/xamarin-android/pull/342)</span>

まず、Androidプロジェクトの`.csproj`ファイルをテキストエディター等で開き、条件(`ConditionGroup`属性が)設定されていない`<PropertyGroup>`タグ配下に、以下の記述を追加します。

```
<AndroidManifestPlaceholders Condition=" '$(AndroidManifestPlaceHolders)' == '' ">
    AppCenterSecret=default
</AndroidManifestPlaceholders>
```

ここで、`$(AndroidManifestPlaceHolders)`は、`msbuild`による
ビルドプロセスの環境変数を参照しています。

`AppCenterSecret=default`の箇所は環境変数が設定されていない場合のデフォルト値で、Visual Studio上でビルドが実行されている場合を想定しています。

続いて、AndroidProjectの`Properties/AndroidManifest.xml`の`<application>`タグを以下の通り修正します。

```
<application android:label="CalendarViewer.Android">
  <meta-data android:name="AppCenterSecret" android:value="${AppCenterSecret}"/>
</application>
```

最後に、Androidプロジェクトの`MainActity.cs`内のAppCenterのSDKの起動処理を以下の通りに修正します。

```
using Android.Content.PM;
(略)
var secret = PackageManager.GetApplicationInfo("jp.fieldnotes.tf06.CalendarViewer", PackageInfoFlags.MetaData).MetaData.GetString("AppCenterSecret");
AppCenter.Start(secret, typeof(Analytics), typeof(Crashes), typeof(Distribute));
```

ここで、`jp.fieldnotes.tf06.CalendarViewer`の箇所は、
`Properties/AndroidManifest.xml`で指定しているアプリケーションのパッケージ名であり、`<manifest>` 要素の `package` 属性で指定しているものです。

最後に、App Centerの「Build Configuration」の「Environment Variable」の項目に環境変数「AppCenterSecret」を追加してビルドします。


- http://www.raghurana.com/building-and-deploying-apps-using-vsts-and-hockeyapp-part-2nbsp-android


