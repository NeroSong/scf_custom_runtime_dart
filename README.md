# scf_custom_runtime_dart

基于腾讯云函数 Custom Runtime 的 Dart 云函数模板，支持推送后自动部署。

## 🤔 Why

Flutter 写的很爽，想用 Dart 把后端也写了。容器化时代，后端语言之间已没有太大差别，选择熟悉的效率更高。且 Dart 在 AOT 编译后冷启动速度也很快，可以满足大部分场景需要。

> 支持其他 Serverless 的云函数，如阿里云函数计算，AWS Lambda 等。按照对应文档修改 Custom Runtime 部分的配置即可。

## 📌 前置条件

需要先新建一个腾讯云函数，类型为 Hello World 示例，运行环境选择 Custom Runtime。

记住函数名和选择的地域，下面要更新部署脚本字段。

## 🪜 初始化流程

1. 更改 `pubspec.yaml` 中的 `name_to_change` 为你的项目名称（需符合 dart 规范，如 `my_scf_dart`）。
2. 更新 `deploy/upload-zip.py` 中的 函数名，函数地域，SecretId 和 SecretKey 字段。
3. 删除 .git 目录，重新初始化，推送到自己的 GitHub 私有仓库。
4. 推送代码到 deploy 分支，等待 actions 完成编译部署。

> 注意：添加腾讯云账户 SecretId 和 SecretKey，需注意密钥对的保密，切勿在公开仓库中写明

## 🎯 验证和测试

推送之后可通过如下方式验证部署是否成功。

### 编译&部署

查看 GitHub Actions 页面，是否顺利完成 build & deploy 工作流

> 一般为推送后约 1 分钟完成

### 检查日志

查看工作台部署日志，最新一条是否为推送的时间。

### 测试云函数

在工作台选择该函数，进入 函数管理-函数代码，选择 Api Gateway 事件模板，更改paht为 `/ping`，执行测试。

如返回包含`{"msg": "pong"}`和请求参数的 JSON 字符串，则整个流程测试成功。

后续每次部署，推送至 deploy 分支即可。

## 🥳 上线

1. 为云函数添加触发器，类型为 API 网关触发。
2. 配置好对应的 API 网关服务，并发布到线上环境。

完成了。后续网关设置不动时，无需再次发布。

## 💡 其他

本质上是一个 Dart Http 轮询和异步方法的包装。

如需连接数据库等，可在 `handler.initSource()` 方法中初始化，将实例传递给后续的业务方法。

本地开发似乎没有什么与线上完全一致的好方法，轮询部分基本稳定，建议通过单元测试来保证业务代码的健壮程度。

上线时尽量先通过 API 网关做分流测试，再全量上线。

---

Dart Serverless 💙