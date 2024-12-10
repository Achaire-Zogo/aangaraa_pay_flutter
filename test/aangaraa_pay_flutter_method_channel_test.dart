import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aangaraa_pay_flutter/aangaraa_pay_flutter_method_channel.dart';

void main() {
  MethodChannelAangaraaPayFlutter platform = MethodChannelAangaraaPayFlutter();
  const MethodChannel channel = MethodChannel('aangaraa_pay_flutter');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
