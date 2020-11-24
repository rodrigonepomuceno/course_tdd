import 'dart:convert';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:meta/meta.dart';

import 'package:course_tdd/data/http/http_client.dart';

class HttpAdapter implements HttpClient {
  final Client client;

  HttpAdapter(this.client);

  Future<Map> request({
    @required String url,
    @required String method,
    Map body,
  }) async {
    final headers = {
      'content-type': 'application/json',
      'accept': 'application/json',
    };
    final jsonBody = body != null ? jsonEncode(body) : null;
    final response = await client.post(url, headers: headers, body: jsonBody);
    if (response.statusCode == 200) {
      return response.body.isEmpty ? null : jsonDecode(response.body);
    } else {
      return null;
    }
  }
}

class ClientSpy extends Mock implements Client {}

void main() {
  ClientSpy client;
  HttpAdapter sut;
  String url;

  setUp(() {
    client = ClientSpy();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
  });
  group('post', () {
    PostExpectation mockResquest() => when(client.post(any, body: anyNamed('body'), headers: anyNamed('headers')));

    void mockResponse(int statusCode, {String body = '{"any_key":"any_value"}'}) {
      mockResquest().thenAnswer((_) async => Response(body, statusCode));
    }

    setUp(() {
      mockResponse(200);
    });

    test(
      'Should call post with correct values',
      () async {
        await sut.request(url: url, method: 'post', body: {'any_key': 'any_value'});
        verify(
          client.post(
            url,
            headers: {
              'content-type': 'application/json',
              'accept': 'application/json',
            },
            body: '{"any_key":"any_value"}',
          ),
        );
      },
    );
    test(
      'Should call post without body',
      () async {
        await sut.request(url: url, method: 'post');
        verify(
          client.post(
            any,
            headers: anyNamed('headers'),
          ),
        );
      },
    );
    test(
      'Should retur data if post returns 200',
      () async {
        final response = await sut.request(url: url, method: 'post');
        expect(response, {'any_key': 'any_value'});
      },
    );
    test(
      'Should retur null if post returns 200 whith no data',
      () async {
        mockResponse(200, body: '');
        final response = await sut.request(url: url, method: 'post');
        expect(response, null);
      },
    );
    test(
      'Should retur null if post returns 204',
      () async {
        mockResponse(204, body: '');
        final response = await sut.request(url: url, method: 'post');
        expect(response, null);
      },
    );
    test(
      'Should retur null if post returns 204 with data',
      () async {
        mockResponse(204);
        final response = await sut.request(url: url, method: 'post');
        expect(response, null);
      },
    );
  });
}
