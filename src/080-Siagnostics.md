
# Diagonstics

Diagonsticsは、日本語に訳すと「診断」という意味ですが、AppCenterでは、
アプリケーションのクラッシュならびにエラー発生の情報を収集することができます。



## Crash Report

アプリケーション上で、意図的にクラッシュを起こすためには、
アプリケーション上で`Microsoft.AppCenter.Crashes`クラスの`GenerateTestCrash`メソッドを呼び出します。

```
MenuItemType id = ((HomeMenuItem)e.SelectedItem).Id;
if (id == MenuItemType.Crash)
{
    Crashes.GenerateTestCrash();
}
```

![メニュバー](img/080/img-080-100.png){#fig:img_080_100_image}

![メニュバー](img/080/img-080-200.png){#fig:img_080_200_image}

## エラーの

## 実機での起動テスト(Test on real device)

App CenterのDiagonsticsで収集できるエラー及びクラッシュは、アプリケーションの起動処理で
AppCenterのSDKが起動した後に発生するものです。

これより前に発生するエラーは、AppCenterでは収集することができません。


