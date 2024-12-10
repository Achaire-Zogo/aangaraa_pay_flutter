import 'package:flutter_test/flutter_test.dart';
import 'package:aangaraa_pay_flutter/aangaraa_pay_flutter.dart';
import 'package:aangaraa_pay_flutter/aangaraa_pay_flutter_platform_interface.dart';
import 'package:aangaraa_pay_flutter/aangaraa_pay_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAangaraaPayFlutterPlatform
    with MockPlatformInterfaceMixin
    implements AangaraaPayFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final AangaraaPayFlutterPlatform initialPlatform = AangaraaPayFlutterPlatform.instance;

  test('$MethodChannelAangaraaPayFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAangaraaPayFlutter>());
  });

  test('getPlatformVersion', () async {
    AangaraaPayFlutter aangaraaPayFlutterPlugin = AangaraaPayFlutter();
    MockAangaraaPayFlutterPlatform fakePlatform = MockAangaraaPayFlutterPlatform();
    AangaraaPayFlutterPlatform.instance = fakePlatform;

    expect(await aangaraaPayFlutterPlugin.getPlatformVersion(), '42');
  });
}