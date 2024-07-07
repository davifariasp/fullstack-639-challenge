abstract class IHttpUse {
  Future get(
      {required String url, required Map<String, String>? headers});

  Future post(
      {required String url,
      required Map<String, String>? headers,
      required Map<String, dynamic>? body});

  Future put(
      {required String url,
      required Map<String, String>? headers,
      required Map<String, dynamic>? body});

  Future delete(
      {required String url, required Map<String, String>? headers});
}
