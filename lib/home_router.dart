import 'dart:convert';

class HomeRouter {
  final String body;
  final Map<String, dynamic> query;
  final String httpMethod;
  final String path;

  HomeRouter({
    required this.body,
    required this.query,
    required this.httpMethod,
    required this.path,
  });

  Future<String> onRes() async {
    // 路径`/ping` 返回请求的各项参数，否则返回 Not Found
    if (path.startsWith('/ping')) {
      final ans = json.encode({
        'msg': 'pong',
        'data': {
          'body': body,
          'query': query,
          'httpMethod': httpMethod,
          'path': path,
        }
      });

      return ans;
    }

    return 'Not Found';
  }
}
