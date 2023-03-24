# scf_custom_runtime_dart

基于腾讯云函数 Custom Runtime 的 Dart 云函数模板，支持推送后自动部署。

## 前置条件

需要先新建一个腾讯云函数，类型为 Hello World 示例，运行环境选择 Custom Runtime。

记住函数名和选择的地域，后续会用到。

## 初始化流程

1. 更改 pubspec.yaml 中的 `name_to_change` 为你的项目名称（需符合 dart 规范，如 `my_scf_dart`）。
2. 更新 deploy/upload-zip.py 中的 函数名，函数地域 字段。
3. 删除 .git 目录，重新初始化仓库，推送到 GitHub。
4. 推送代码到 deploy 分支，等待 actions 打包完成后自动部署。

如测试访问正常，返回 NotFound，则为初始化完成。

可以清空该READM文件，重新初始化git仓库，正常开始开发流程。

