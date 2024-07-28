import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> initialize() async {
    try {
      await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: Duration(seconds: 10),
        minimumFetchInterval: Duration(hours: 1),
      ));

      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      print('Failed to fetch remote config: $e');
    }
  }

  String getStringValue(String key) {
    return _remoteConfig.getString(key);
  }

  int getIntValue(String key) {
    return _remoteConfig.getInt(key);
  }

  bool getBoolValue(String key) {
    return _remoteConfig.getBool(key);
  }
}
