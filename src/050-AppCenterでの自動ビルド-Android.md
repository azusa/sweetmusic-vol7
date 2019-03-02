# App CenterによるAndroidアプリの自動ビルド



- Androidのキー作成

https://docs.microsoft.com/ja-jp/xamarin/android/deploy-test/release-prep/index?tabs=windows#archive


場所

Visual Studio上で作成したkeystore

```
%USERPROFILE%\AppData\Local\Xamarin\Mono for Android\Keystore
```

## Visual Studioが使用しているXamarin.Formsのバージョンを確認する方法

App Centerのビルド設定には、SDK versionの指定する箇所があります。
ローカルのVisual Studio上でビルドする時に使用していたの
Xamarin.Androidのバージョンを確認するには、Visual Studioのメニューの「ヘルプ」→「バージョン情報」から、「インストールされている製品」の表示でXamarin.Android SDNのバージョンの表示を見ます。<span class="footnote"> [https://stackoverflow.com/a/51417938](https://stackoverflow.com/a/51417938) </span>

## Sign Build

App Center上での実機テスト(Test on real device)および、APKの端末への配布を行うには、以下の設定がビルドごとに必要です。

KeyStoreでビルドが署名されていること

Andoirプロジェクトの設定で、「Androidオプション」→「共有ランタイム」の使用にチェックが入っていないことが必要です。

Xamarin.Anroidでは、デバッグ時に、共有ランタイム(Shared RuntimeないしMono Shared Runtimeと呼ばれる)」と呼ばれるユーザーアプリケーションとは別のパッケージをインストールします。

これは、一つのXamarin.Androidパッケージにつき、一度だけ行われます。 共有ランタイムとは、デバッグビルドを行う際に、アセンブリビルドの工程を省略し、ビルドおよび起動の時間の短縮をするために行われるものです。<span class="footnote">[https://www.buildinsider.net/mobile/insidexamarin/09](https://www.buildinsider.net/mobile/insidexamarin/09)</span>

App CenterでビルドしたAPKをインストールする際は、この共有ランタイムのインストールが行われないため、この設定が有効になっているとAPKが起動しません。

「共有ランタイム」の設定は、Visual Studio2017で作成したXamarin.Andoroidのデフォルトでは、
Debugビルドでは有効、Releaseビルドでは有効になっています。

(かつAppCenterのデフォルトはDebugビルド)

この設定を確認・変更するには、Xamarin.Androidプロジェクトのプロパティ上の「Androidオプション」→「パッケージング プロパティ」上の、
「共有ランタイム」のチェックを確認します。

Visual Studio For Macの場合はXamarin.Androidプロジェクトのプロパティ上の「ビルド」→「Androidのビルド」→「General」内の、「共有Monoランタイムを使用」です。

App CenterでXamarin.Androidプロジェクトのビルドを行う場合、
この設定は `.csproj`ファイル内の記述を通じて、ローカルでのビルド・デバッグを行う際と、App Center上でビルドを行う際に共有されます。

