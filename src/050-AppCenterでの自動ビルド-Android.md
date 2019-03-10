# App CenterによるAndroidアプリの自動ビルド

## Visual Studioが使用しているXamarin.Formsのバージョンを確認する方法

App Centerのビルド設定には、SDKのversionを指定する箇所があります。

ローカルのVisual Studio上でビルドする時に使用していた
Xamarin.Androidのバージョンを確認するには、Visual Studioのメニューの「ヘルプ」→「バージョン情報」から、「インストールされている製品」の表示でXamarin.Android SDKのバージョンの表示を参照します。<span class="footnote"> [https://stackoverflow.com/a/51417938](https://stackoverflow.com/a/51417938) </span>

## Sign Build

App Center上での実機テスト(Test on real device)および、APKの端末への配布を行うには、以下の設定がビルドごとに必要です。

- KeyStoreでビルドが署名されていること

Andoirプロジェクトの設定で、「Androidオプション」→「共有ランタイム」の使用にチェックが入っていないことが必要です。

Xamarin.Anroidでは、デバッグ時に、共有ランタイム<span class="footnote">Shared RuntimeないしMono Shared Runtimeと呼ばれる</span>という、ユーザーアプリケーションとは別のパッケージをインストールします。

これは、一つのXamarin.Androidパッケージにつき、一度だけ行われます。 共有ランタイムとは、デバッグビルドを行う際に、アセンブリビルドの工程を省略し、ビルドおよび起動の時間の短縮をするために行われるものです。<span class="footnote">[https://www.buildinsider.net/mobile/insidexamarin/09](https://www.buildinsider.net/mobile/insidexamarin/09)</span>

App CenterでビルドしたAPKを端末にインストールする際は、この共有ランタイムのインストールが行われないため、この設定が有効になっているとAPKが起動しません。

「共有ランタイム」の設定は、Visual Studio2017で作成したXamarin.Andoroidのデフォルトでは、
Debugビルドでは有効、Releaseビルドでは有効になっています。

(かつAppCenterのデフォルトはDebugビルド)

この設定を確認・変更するには、Xamarin.Androidプロジェクトのプロパティ上の「Androidオプション」→「パッケージング プロパティ」上の、
「共有ランタイム」のチェックを確認します。

Visual Studio For Macの場合はXamarin.Androidプロジェクトのプロパティ上の「ビルド」→「Androidのビルド」→「General」内の、「共有Monoランタイムを使用」です。

App CenterでXamarin.Androidプロジェクトのビルドを行う場合、
この設定は `.csproj`ファイル内の記述を通じて、ローカルでのビルド・デバッグを行う際と、App Center上でビルドを行う際に共有されます。

## Simulatorビルド

## Signed ビルド

- 設定間違えたらビルド最後までいかないとわからないからね！

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

## 実機での起動テスト(Test on real device)

## API Keyなどの管理の方法～コード書き換え

- https://qiita.com/amay077/items/aac34280feefd7a1db8c
- http://shimbaroid.hatenablog.jp/entry/2016/08/15/010350

## AndroidManifestPlaceholdersによるビルド時の環境変数の書き換え

- http://www.raghurana.com/building-and-deploying-apps-using-vsts-and-hockeyapp-part-2nbsp-android
- https://github.com/xamarin/xamarin-android/pull/342
