import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'aangaraa_pay_flutter_platform_interface.dart';

/// An implementation of [AangaraaPayFlutterPlatform] that uses method channels.
class MethodChannelAangaraaPayFlutter extends AangaraaPayFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('aangaraa_pay_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
