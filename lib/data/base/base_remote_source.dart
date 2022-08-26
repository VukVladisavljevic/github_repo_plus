import 'dart:convert';

import '../../main.dart';
import '../../core/util/failure.dart';
import 'package:http/http.dart';

enum RequestType {
  get,
  post,
  put,
  patch,
  delete,
}

abstract class BaseRemoteSource {
  static const _notFountCode = 404;
  static const successStatusCodes = [200, 201];

  final _jsonDeserializationError = 'The provided string is not valid JSON';

  final String coinsAPI = 'https://api.coingecko.com/api/v3/';

  final Client _client = getIt<Client>();

  Future<T> execute<T>(
    RequestType remoteCallType,
    String endpoint,
    Function jsonMapper, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? requestBody,
  }) async {
    final response =
        await _createApiRequest(remoteCallType, endpoint, queryParams: queryParams, requestBody: requestBody);
    if (successStatusCodes.contains(response.statusCode)) {
      try {
        return jsonMapper(json.decode(utf8.decode(response.bodyBytes)));
      } on FormatException catch (e, trace) {
        throw Failure(_jsonDeserializationError, errorTrace: trace);
      }
    } else {
      throw response.statusCode == _notFountCode ? NotFoundFailure() : Failure(response.reasonPhrase);
    }
  }

  Future<Response> _createApiRequest(
    RequestType remoteCallType,
    String endpoint, {
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? requestBody,
  }) {
    final url = queryParams != null ? Uri.parse(endpoint).replace(queryParameters: queryParams) : Uri.parse(endpoint);
    switch (remoteCallType) {
      case RequestType.get:
        return _client.get(url);
      case RequestType.post:
        return _client.post(url, body: json.encode(requestBody));
      case RequestType.put:
        return _client.put(url, body: json.encode(requestBody));
      case RequestType.patch:
        return _client.patch(url, body: json.encode(requestBody));
      case RequestType.delete:
        return _client.delete(url);
    }
  }
}
