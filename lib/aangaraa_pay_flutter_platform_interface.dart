import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'aangaraa_pay_flutter_method_channel.dart';

abstract class AangaraaPayFlutterPlatform extends PlatformInterface {
  /// Constructs a AangaraaPayFlutterPlatform.
  AangaraaPayFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static AangaraaPayFlutterPlatform _instance = MethodChannelAangaraaPayFlutter();

  /// The default instance of [AangaraaPayFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelAangaraaPayFlutter].
  static AangaraaPayFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AangaraaPayFlutterPlatform] when
  /// they register themselves.
  static set instance(AangaraaPayFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
