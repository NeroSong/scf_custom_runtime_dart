import 'dart:io';

import 'package:dio/dio.dart';
import '../home_router.dart';

void main(List<String> args) async {
  final handler = Handler();
  await handler.initSource();
  await handler.loopHttp();
}

class Handler {
  static const urlNext = '/runtime/invocation/next';
  static const urlOver = '/runtime/invocation/response';
  static const urlError = '/runtime/invocation/error';

  late final Dio dio;

  Future initSource() async {
    final baseCRUrl =
        'http://${Platform.environment['SCF_RUNTIME_API'].toString()}'
        ':${Platform.environment['SCF_RUNTIME_API_PORT'].toString()}';

    dio = Dio(BaseOptions(
      // 一直长轮询监听新请求，不能超时
      sendTimeout: Duration(days: 1),
      connectTimeout: Duration(days: 1),
      receiveTimeout: Duration(days: 1),
      baseUrl: baseCRUrl,
    ));

    print('Resource initialized');
  }

  Future loopHttp() async {
    // 保持循环，即使出错也不退出
    while (true) {
      try {
        final ans = await dio.get(urlNext);
        print('new request');
        // 可获取的所有参数
        print(ans.data.toString());

        // 部分API网关触发的参数
        final mainRoute = HomeRouter(
          body: ans.data['body'].toString(),
          query: ans.data['queryString'],
          httpMethod: ans.data['httpMethod'].toString(),
          path: ans.data['path'].toString(),
        );

        // 执行业务逻辑
        final res = await mainRoute.onRes();
        // 返回处理结果
        await dio.post(urlOver, data: res);

        print('request over');
      } catch (e) {
        print(e.toString());
        await dio.post(urlError, data: e.toString());
      }
    }
  }
}
