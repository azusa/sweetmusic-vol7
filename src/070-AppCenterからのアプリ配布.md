# App Centerからのアプリ配布

App Centerでは、ビルドしたアプリケーションを、テストなどの用途で使用するユーザーに対して配布
することができます。

App Centerからアプリケーションを配布するには、ビルドが以下の条件を満たしている必要があります。

- ビルドがデジタル署名されていること

以下は、Androidアプリケーションの条件です。

- 「不明なアプリのインストール」のパーミッションが許可されていること
-  Shared Runtimeを使用したビルドでないこと

以下は、iOSアプリケーションの条件です。

- Device Buildであること
- ビルドする際に指定したProvisioning Profileの対象に、アプリケーションをインストールする端末が含まれていること。

## Distrubution Group

App Centerからアプリケーションを配布するには、配布時にユーザーを個別に指定するか、
対象のユーザーを含んだグループ(Distrubution Group)を作成します。

Distribution Groupを作成するには、メニューの「Distribute」→「Groups」から、
～のような流れでグループを作成します。

##

ビルドしたアプリケーションをDistribution Groupに配布するには、
ビルドの結果画面から、～のような流れでアプリケーションを配布します。

アプリケーションを配布すると、対象のユーザーのアカウントにメールが届きます。
そのメール中のリンクからApp Centerのダウンロード画面にアクセスし、アプリケーションをダウンロードしてインストールします。

iOSアプリケーションの場合は、初回インストール時に、～のように、端末に対しプロファイルのインストールが指示されますので、プロファイルの内容を確認し、インストールを行います。

なお、App Centerのビルドの設定の「Disribute Build」の設定を有効にすると、
対象のブランチのビルドが成功するごとに、自動でアプリケーションを配布することができます。


## アプリ内のパーミッション許可

Android8.0(Oreo)から、Play Storeを経由しないで配布されているアプリケーション<span class="footnote">いわゆる野良アプリ</span>のインストールへの許可は、
APKファイルをダウンロードするアプリケーションごとに行うようになりました。

このため、App CenterからAndroidアプリケーションをインストールする場合は、
App Centerにアクセスし、APKファイルをダウンロードするブラウザーに対し、このパーミッションを許可する必要があります。

インストールのパーミッションを許可するには、～のようにAndroidの設定の「アプリと通知」→該当するブラウザー<span class="footnote">この例ではFirefox</span>→「不明なアプリのインストール」と辿って、設定を行います。

この後述べるアプリ内更新(In-App Update)を使用する場合は、このパーミッションは
初回のインストール時に許可した後は、設定を戻して大丈夫です。

## In-App Update(アプリ内更新)

App Centerは、インストールしたアプリケーションの新しいバージョンが配布された場合に、
アプリケーション内で新しいバージョンに更新を行う機能があります。この機能を
In-App Updateと呼びます。

In-App Updateの機能を使用するには、アプリケーションのビルドが以下の条件を満たしている必要があります。

- ビルドバージョンが更新されていること
- Microsoft.AppCenter.Distributeが組み込まれていること
- Debugビルドでないこと<span class="footnote">App Centerのドキュメントでは「Releaseビルドであること」となっていますが、Releaseビルドの設定を元に新しい構成を作成した場合もIn-App Updateは適用されます。</span>
- iOSアプリケーションの場合は、`Info.plist`にApp Centerのアプリケーションのシークレットが設定されていること(後述)
- アプリケーションが、配布した際の通知メール中のリンク先のページからダウンロードされていること

なお、Google Play(Android)ならびにApp Store(iOS)からインストールしたアプリケーションの場合は、In-App Updateの機能は無効になります。

## iOSアプリケーションのシークレットの設定

iOSアプリケーションでIn-App Updateの機能を有効にするには、`Info.plist`に以下の様にApp Centerのアプリケーションのシークレットを設定する必要があります。

```
  <array>
      <dict>
          <key>CFBundleURLSchemes</key>
          <array>
              <string>appcenter-(AppCenterのiOSアプリケーションのシークレット)</string>
          </array>
      </dict>
  </array>
```  

## ビルドバージョン

In-App Updateは、新しいビルドが行われた時に、以下の手順でアプリケーションが更新されたと判断します。<span class="footenote">[https://docs.microsoft.com/en-us/appcenter/distribution/inappupdates](https://docs.microsoft.com/en-us/appcenter/distribution/inappupdates)</span>

Androidアプリケーションの場合は、`AndroidManifest.xml`で`versionCode`ないし`versionName`がインクリメントされていることです。

iOSアプリケーションの場合は、`Info.plist`で`CFBundleShortVersionString`ないし`CFBundleVersion`がインクリメントされていることです。

App Centerでは、ビルドの設定の「Automatically increment version code」の
チェックを有効にすることで、ビルド時にこれらのバージョンを自動でインクリメントすることができます。

## ダウンロード先

In-App Updateの対象となるのは、配布した際の通知メール中のリンク先のページ(`install.appcenter.ms`ドメイン)です。App Centerではメニューの「Distribute」→「Releases」の各リリース画面からもアプリケーションをダウンロードしたインストールすることができますが、この場合はIn-App Updateは無効になります。

## In-App Updateの挙動

In-App Updateが組み込まれているアプリケーションをインストールすると、アプリケーション内でブラウザーが開き、App Centerにアクセスします。この際、アプリケーション内に組み込まれているアプリケーションのシークレットを使ってApp Centerに認証を行い、認証が
有効だった場合にIn-App Updateが有効になります。

In-App Updateが有効な状態で新しいバージョンのアプリケーションがリリースされると、～のようにアプリケーション内でダウンロードのポップアップが開きます。ポップアップの指示に従ってダウンロードすると、新しいバージョンのアプリケーションをダウンロードしてインストールします。

先述の通り、Android8.0(Oreo)から、Play Storeを経由しないで配布されているアプリケーション<span class="footnote">いわゆる野良アプリ</span>のインストールへの許可は、
APKファイルをダウンロードするアプリケーションごとに行うようになっています。

このため、AndrodoiアプリケーションでIn-App Updateを有効にするには、そのアプリケーションの「不明なアプリのインストール」のパーミッションを許可する必要があります。