import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class CheckInternetConnection {
  Future<bool> get isConnected;
}

class CheckInternetConnectionImpl implements CheckInternetConnection {
  final InternetConnection internetConnection;

  CheckInternetConnectionImpl({required this.internetConnection});

  @override
  Future<bool> get isConnected async =>
      await internetConnection.hasInternetAccess;
}
