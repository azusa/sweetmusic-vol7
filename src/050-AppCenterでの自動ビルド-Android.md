# App CenterによるAndroidアプリケーションの自動ビルド

この設定では、App CenterでAndroidアプリケーションの自動ビルドを行うために、ブランチごとに必要な設定を説明します。

App Centerのビルドの設定のための画面は、「Build」のメニューを選択して表示される「Branches」画面の、右側の歯車を選択して表示します。

## Configration

「Configuration」では、ビルドを行う際の構成を選択します。

Visual Studioの「構成マネージャー」の「構成」の設定に相当します。

App CenterでAndroidアプリケーションをビルドする際、ビルドしたAPK<span class="footnote">Android application package </span>ファイルを
実機で起動する場合は、通常「Configuration」を「Relelase」に設定します。

App Centerで、実機テスト(Test on real device)および、APKの端末への配布を行うには、以下の設定がビルドごとに必要です。

- Andoirプロジェクトの設定で、「Androidオプション」→「共有ランタイム」の使用にチェックが入っていないこと
- KeyStoreでビルドが署名されていること(後述)

Xamarin.Anroidでは、デバッグ時に、共有ランタイム<span class="footnote">Shared RuntimeないしMono Shared Runtimeと呼ばれる</span>という、
ユーザーアプリケーションとは別のパッケージをインストールします。

これは、一つのXamarin.Androidパッケージにつき、一度だけ行われます。 共有ランタイムとは、デバッグビルドを行う際に、アセンブリビルドの工程を省略し、ビルドおよび起動の時間の短縮をするために行われるものです。<span class="footnote">[https://www.buildinsider.net/mobile/insidexamarin/09](https://www.buildinsider.net/mobile/insidexamarin/09)</span>

App CenterでビルドしたAPKファイルを端末にインストールする際は、この共有ランタイムのインストールが行われないため、この設定が有効になっているとアプリケーションが起動しません。

「共有ランタイム」の設定は、Visual Studio2017で作成したXamarin.Andoroidのデフォルトでは、
Debugビルドでは有効、Releaseビルドでは有効になっています。

この設定を確認・変更するには、Xamarin.Androidプロジェクトのプロパティ上の「Androidオプション」→「パッケージング プロパティ」上の、
「共有ランタイム」のチェックを確認します。

Visual Studio For Macの場合はXamarin.Androidプロジェクトのプロパティ上の「ビルド」→「Androidのビルド」→「General」内の、「共有Monoランタイムを使用」です。

App CenterでXamarin.Androidプロジェクトのビルドを行う場合、
この設定は `.csproj`ファイル内の記述を通じて、ローカルでのビルド・デバッグを行う際と、App Center上でビルドを行う際に共有されます。

## SDKバージョンの指定

「SDK Version」では、ビルドに使用するSDKのバージョンを指定します。

Visual Studio上でビルドする時に使用していた
Xamarin.Androidのバージョンを確認するには、Visual Studioのメニューの「ヘルプ」→「バージョン情報」から、
「インストールされている製品」の表示でXamarin.Android SDKのバージョンの表示を参照します。<span class="footnote"> [https://stackoverflow.com/a/51417938](https://stackoverflow.com/a/51417938) </span>

## Build Script

App Centerでは、ソリューションファイル(.sln)の設定に従ってビルドを行いますが、
以下の三カ所のポイントにおいて、スクリプトによる処理を差し込むことができます。

- Gitレポジトリーからのクローンの後(Post-clone)
- ビルドの前(Pre-build)
- ビルドの後(Post-build)

スクリプトに処理を追加するには、以下のファイル名のスクリプトをリポジトリーにコミットします。

### Post-clone

- appcenter-post-clone.sh (iOSまたはAndroid)
- appcenter-post-clone.ps1 (UWP)

### Pre-build

- appcenter-pre-build.sh (iOSまたはAndroid)
- appcenter-pre-build.ps1 (UWP) 

### Post-build

- appcenter-post-build.sh (iOSまたはAndroid)
- appcenter-post-build.ps1 (UWP)


## Sign Build

「Sign Build」の項目では、アプリケーションに対するデジタル署名の設定を行います。

App CenterでのAndoroidアプリケーションの実機テスト(Test on real device)および、APKの端末への配布を行うには、
APKファイルに対し、デジタル署名が行われている必要があります。<span class="footnote">https://developer.android.com/guide/publishing/app-signing?hl=ja</span>

「Sign Build」の項目ではデジタル署名に行うキーストアのファイルをアップロードし、以下の設定を行います。

- キーストアのパスワード(Keystore password)
- キーの別名(Key alias)
- キーのパスワード(Key password)

なお、キーストアのパスワード等の設定が誤っている場合、エラー文言を介さず設定を保存することが出来ますが、
ビルド処理時の最後のステップの、アプリケーションへのデジタル署名を行う段階でビルドエラーとなります。

この挙動は、iOSアプリケーションの設定の挙動とは異なりますので、注意が必要です。

## Visual Studioで鍵を作成した場合の鍵の場所

- Androidのキー作成

- Android Studioでつくる
- JDKのkeytoolコマンド
- VS

https://docs.microsoft.com/ja-jp/xamarin/android/deploy-test/release-prep/index?tabs=windows#archive



```
%USERPROFILE%\AppData\Local\Xamarin\Mono for Android\Keystore
```

## ブランチが増えた場合の設定

## API Keyなどの管理の方法～コード書き換え

- https://qiita.com/amay077/items/aac34280feefd7a1db8c
- http://shimbaroid.hatenablog.jp/entry/2016/08/15/010350

## AndroidManifestPlaceholdersによるビルド時の環境変数の書き換え

- http://www.raghurana.com/building-and-deploying-apps-using-vsts-and-hockeyapp-part-2nbsp-android
- https://github.com/xamarin/xamarin-android/pull/342
