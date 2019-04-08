# Visual Studio App Center

Visual Studio App Center<span class="footnote">以下App Center</span>は、
マイクロソフト社により提供されている、アプリケーションに特化した開発プラットフォームサービスです。

2016年の11月にVisual Studio Mobile Centerとしてプレビューが公開され、2017年11月にGAしました。

App Centerのサービスは、以下のドメインで提供されています。

- [https://appcenter.ms/](https://appcenter.ms/)

また、App Centerに関するドキュメントは、Microsoft Docsの以下のURLで提供されています。

- [https://docs.microsoft.com/en-us/appcenter/](https://docs.microsoft.com/en-us/appcenter/)

App Centerは、アプリケーションの開発者向けに、以下のサービスを提供しています。

- アプリケーションのビルド
- デバイス上でのテスト
- チーム内へのビルドしたアプリケーションの配布
- アプリケーションのクラッシュ情報のレポート
- アプリケーションの使用状況の分析
- プッシュ通知

また、以下のOS/プラットフォームのビルドをサポートしています。

### サポートしているOS

- iOS
- Android
- Windows
- macOS(プレビュー)

### サポートしているプラットフォーム

- Objective-C /Swift
- React Native
- Xamarin
- Unity
- Cordova(プレビュー)

本書では、この機能のうち、アプリケーションのビルド、アプリケーションの配布、クラッシュ情報の分析の機能を中心として取り上げます。

## App Centerのプラン

App Centerの料金プランは、次のサイトに掲載されています。

- [https://visualstudio.microsoft.com/ja/app-center/pricing/](https://visualstudio.microsoft.com/ja/app-center/pricing/)
- [https://docs.microsoft.com/en-us/appcenter/general/pricing](https://docs.microsoft.com/en-us/appcenter/general/pricing)

また、無料プランでは、次の機能を使用することができます。

- 1ヶ月あたり240ビルド時間、1ビルドあたり最長30分
- 実機でのUIテストに対する、30 日間の無料試用版
- プッシュ通知のユーザーセグメントは5つまで

また、無料プランにおいて、以下の機能は使用に制限がありません。

- アプリケーションのクラッシュ情報の分析
- アプリケーションの配布
- クラッシュレポート
- 実機での起動テスト

また、Visual Studioのサブスクリプションがある場合は、サブスクリプションの特典としてApp Centerを使用することができます。<span class="footnote">[https://docs.microsoft.com/en-us/visualstudio/subscriptions/vs-visual-studio-app-center](https://docs.microsoft.com/en-us/visualstudio/subscriptions/vs-visual-studio-app-center) </span> サブスクリプションの特典を有しているかは、以下のURLのページの表示から確認することができます。

- [https://my.visualstudio.com/benefits](https://my.visualstudio.com/benefits)

<div class="block">

### MicrosoftアカウントとAzure ADアカウント

App Centerの組織の管理者がユーザーを招待した場合、
招待したメールアドレスのドメインを使用して、セルフサインアップテナント
と呼ばれるAzure Active Directory(Azure AD)のテナントが、
システムによって作成されます。

この際、招待したユーザーが既にMicrosoftアカウントを使用していると、
Azureポータルを始めとするMicrosoftのサービス上では、同一のIDで
アカウントが二つ存在している状態となります。<span class="footnote">Azure ADがいつの間にか作られてて結構困った話 [https://blog.divakk.co.jp/entry/2017/12/13/195630](https://blog.divakk.co.jp/entry/2017/12/13/195630)</span><span class="footnote">#AzureAD と Microsoft アカウントの重複問題に対する取り組み [https://blogs.technet.microsoft.com/mssvrpmj/2016/09/30/azuread-%E3%81%A8-microsoft-%E3%82%A2%E3%82%AB%E3%82%A6%E3%83%B3%E3%83%88%E3%81%AE%E9%87%8D%E8%A4%87%E5%95%8F%E9%A1%8C%E3%81%AB%E5%AF%BE%E3%81%99%E3%82%8B%E5%8F%96%E3%82%8A%E7%B5%84%E3%81%BF/](https://blogs.technet.microsoft.com/mssvrpmj/2016/09/30/azuread-%E3%81%A8-microsoft-%E3%82%A2%E3%82%AB%E3%82%A6%E3%83%B3%E3%83%88%E3%81%AE%E9%87%8D%E8%A4%87%E5%95%8F%E9%A1%8C%E3%81%AB%E5%AF%BE%E3%81%99%E3%82%8B%E5%8F%96%E3%82%8A%E7%B5%84%E3%81%BF/)</span>

この場合、App CenterやAzure DevOpsなどのAzure関連サービスでは、Microsoftアカウントでなく、Azure ADのアカウントを使ってサインインすることになります。
</div>

<div class="block">

### App CenterのアプリケーションのURL

App Centerは、アプリケーションの作成後、アプリケーションの名称は設定の画面から変更することができますが、
アプリケーションに対するApp Center上でのURLは変更することができません。

URLを変更したい場合は、App Center上でのアプリケーションを一度削除した後、再作成することになります。

</div>
