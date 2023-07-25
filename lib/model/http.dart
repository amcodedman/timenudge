import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:timenudge/model/appconfig.dart';

class HTTPservic {
  final Dio dio = Dio();
  AppConfig? _appConfig;
  String? url;
  HTTPservic() {
    _appConfig = GetIt.instance.get<AppConfig>();
    url = _appConfig!.API;
  }

  Future<Response?> get(String? path) async {
    try {
      String _url = "$url$path";

      Response _response = await dio.get(_url);

      return _response;
    } catch (e) {
   
    }
  }
}
