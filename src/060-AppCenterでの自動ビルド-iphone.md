# 7.App CenterによるiOSアプリケーションの自動ビルド

この設定では、App CenterでiOSアプリケーションの自動ビルドを行うために、ブランチごとに必要な設定を説明します。

App Centerのビルドの設定のための画面は、「Build」のメニューを選択して表示される「Branches」画面の、右側の歯車を選択して表示します。

Configuration、SDK VersionおよびBuild Scriptについては、Androidと同様です。

## Build Type

App CenterのiOSアプリケーションのビルドには、「Device Build」と端末をUSBで接続して起動するためのビルドである「Simulator Build」の二通りがあります。

「Simulator Build」はビルドが高速に動作します。しかし、App Centerでは「Sumularator Build」でビルドしたipaファイルを端末上で起動することができません。このため、「Sumularator Build」でビルドしたアプリケーションを配布することはできません。

## Provisining Profileの取得

上記の「Device Build」で端末で起動するipaファイルを作成するには、ビルドに
デジタル署名を行う必要があります。

App Centerの「Sign Build」の項目で、Apple Developerサイトに登録した
Provisioning Profileと、Provisioning Profileの作成に使用した証明書
から作成したp12ファイルフォーマットのアーカイブファイルをアップロードします。

Provisiong Profileは、アプリケーションを配布するApple ID保持者の端末を
登録したプロファイルであることが必要です。

上記のような場合は、ビルド設定時の保存時にエラーになります。

- p12ファイルの秘密鍵のパスフレーズが不一致の場合
- Provisioning Profileとp12ファイルの組み合わせが不一致の場合

開発版のアプリケーションと、Appleに申請してApp Storeで公開するアプリケーションでは、
デジタル署名に使うProvoisiong Profileと、p12ファイルの組み合わせが異なります。

この場合、例えば`master`ブランチを、申請用のビルドにするなどの役割を持たせて、
ブランチごとにアップロードするProviosing Profileとp12ファイルの組み合わせを切り替えてビルドします。

## バンドルIDの書き換え

Xamarin.FormsのiOSアプリケーションでは、バンドル識別子が一意である必要があります。

バンドル識別子は、iOSのプロウジェクト配下の`Info.plist`に記述されています。

Appleに申請してApp Storeで公開するアプリケーションと、開発版のアプリケーションを
同一端末にインストールしたいなどで、ブランチごとにバンドル識別子を
切り替えてアプリケーションをビルドすることがあります。

ビルド時にバンドル識別子を切り替えるには、iOSアプリケーションのプロジェクトの`.csproj`と同じ階層に`appcenter-pre-build.sh` を作成して、[@lst:code_060_010]のようなスクリプトを記述します。

```{#lst:code_060_010 caption="`appcenter-pre-build.sh"}
#!/usr/bin/env bash

if [ $APPCENTER_BRANCH != "master" ]; then
  exit 0
fi

plutil -replace  CFBundleIdentifier -string "jp.fieldnotes.experiment.honaka.release.CalendarViewer"  Info.plist
```
