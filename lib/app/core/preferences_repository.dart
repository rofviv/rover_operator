import '../modules/dashboard/utils/relays_data.dart';
import 'local_storage.dart';

abstract class PreferencesRepository {
  Future<String?> get token;
  Future<String?> get userId;

  Future<String?> get ipRemote;
  Future<String?> get sizeIcon;
  Future<Map<Relays, int>?> get relays;

  Future<void> setToken(String token);
  Future<void> setUserId(String userId);

  Future<void> setIpRemote(String ipRemote);
  Future<void> setSizeIcon(String sizeIcon);
  Future<void> setRelays(Map<Relays, int> relays);

  Future<void> clearSession();
}

class PreferencesRepositoryImpl implements PreferencesRepository {
  final LocalStorage _localStorage;

  final String _tokenKey = 'app-token';
  final String _userIdKey = 'app-user-id';

  final String _ipRemoteKey = 'app-ip-remote';
  final String _sizeIconKey = 'app-size-icon';
  final String _relaysKey = 'app-relays';

  PreferencesRepositoryImpl(this._localStorage);

  @override
  Future<void> clearSession() async {
    await _localStorage.clear();
  }

  @override
  Future<void> setToken(String token) async {
    await _localStorage.create(_tokenKey, token);
  }

  @override
  Future<String?> get token => _localStorage.read<String?>(_tokenKey);

  @override
  Future<void> setUserId(String userId) async {
    await _localStorage.create(_userIdKey, userId);
  }

  @override
  Future<String?> get userId => _localStorage.read<String?>(_userIdKey);

  @override
  Future<String?> get ipRemote => _localStorage.read<String?>(_ipRemoteKey);

  @override
  Future<void> setIpRemote(String ipRemote) async {
    await _localStorage.create(_ipRemoteKey, ipRemote);
  }

  @override
  Future<void> setSizeIcon(String sizeIcon) async {
    await _localStorage.create(_sizeIconKey, sizeIcon);
  }

  @override
  Future<String?> get sizeIcon => _localStorage.read<String?>(_sizeIconKey);

  @override
  Future<Map<Relays, int>?> get relays =>
      _localStorage.read<Map<Relays, int>>(_relaysKey);

  @override
  Future<void> setRelays(Map<Relays, int> relays) async {
    await _localStorage.create(_relaysKey, relays);
  }
}
