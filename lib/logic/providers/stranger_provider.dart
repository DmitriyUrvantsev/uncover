import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:uncover/logic/models/account_model.dart';
import 'package:uncover/logic/models/stranger_model.dart';
import 'package:uncover/logic/providers/account_provider.dart';
import 'package:uncover/logic/requests/account_request.dart';
import 'package:uncover/logic/requests/stranger_request.dart';
import 'package:uncover/logic/services/constants_service.dart' as constant;
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../services/shared_prefs_service.dart';

class StrangerProvider extends ChangeNotifier {

  List<StrangerModel>? _strangers;
  String? _errorMessage;

  Future<void> getStrangersFromServer (AccountModel account) async {
    StrangerRequest request = StrangerRequest();
    request.getStrangers(account.authToken, _setStrangersFromHttp);
  }

  void _setStrangersFromHttp(http.Response response) {
    var resultArray = jsonDecode(response.body)["users"] as List;
    strangers = resultArray.map((strangerJson) => StrangerModel.fromJson(strangerJson)).toList();
  }

  set strangers(strangers) {
    _strangers = strangers;
    notifyListeners();
  }

  get strangers => _strangers;

  get count => _strangers != null ? _strangers?.length : 0;
}