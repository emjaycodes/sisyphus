import 'dart:convert';
import 'dart:io';

import 'package:candlesticks/candlesticks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:sisyphus/features/home/data/models/symbols_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

final binanceRepositoryProvider =
    Provider<BinanceRepository>((ref) => BinanceRepository());

class BinanceRepository {
  Future<List<Candle>> fetchCandles({
    required String symbol,
    required String interval,
    int? endTime,
  }) async {
    final uri = Uri.parse(
      'https://api.binance.com/api/v3/klines?symbol=$symbol&interval=$interval${endTime != null ? '&endTime=$endTime' : ''}',
    );
    final res = await http.get(uri);
    print(res.body);
    return (jsonDecode(res.body) as List<dynamic>)
        // ignore: unnecessary_lambdas
        .map((e) => Candle.fromJson(e))
        .toList()
        .reversed
        .toList();
  }

  Future<List<Symbols>> fetchSymbols() async {
    try {
      final uri = Uri.parse('https://api.binance.com/api/v3/ticker/price');
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        return (jsonDecode(res.body) as List<dynamic>)
            .map((e) => Symbols.fromJson(e))
            .toList();
      } else if (res.statusCode == 429) {
        throw Exception('Rate limit exceeded: Please slow down your requests.');
      } else if (res.statusCode == 500) {
        throw Exception('Server error: Binance is experiencing issues.');
      } else {
        throw Exception(
            'Unexpected error: ${res.statusCode} ${res.reasonPhrase}');
      }
    } on SocketException {
      print(
          'Network error: Please check your internet connection or try a VPN.');
      throw Exception('Network error: Unable to connect to Binance API.');
    } catch (e) {
      print('Error in fetchSymbols: $e');
      throw Exception('Unknown error occurred: $e');
    }
  }

  WebSocketChannel establishConnection(String symbol, String interval) {
    final channel = WebSocketChannel.connect(
      Uri.parse('wss://stream.binance.com:9443/ws/btcusdt@trade'),
      // Uri.parse('wss://stream.binance.com:944'),
    );

    streamListener() {
      channel.stream.listen((message) {
        print(message);
      });
    }

    // channel.sink.add(
    //   jsonEncode(
    //     {
    //       'method': 'SUBSCRIBE',
    //       'params': ['$symbol@kline_$interval'],
    //       'id': 1,
    //     },
    //   ),
    // );
    //
    // channel.sink.add(
    //   jsonEncode(
    //     {
    //       'method': 'SUBSCRIBE',
    //       'params': ['$symbol@depth'],
    //       'id': 1,
    //     },
    //   ),
    // );

    channel.sink.add(
      jsonEncode({
        'method': "SUBSCRIBE",
        'params': [
          'btcusdt@aggTrade',
          'btcusdt@depth',
        ],
        "id": 1
      }),
    );

    return channel;
  }
}
