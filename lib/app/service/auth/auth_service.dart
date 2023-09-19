import 'dart:convert';

import 'package:alvamind_library_two/app/service/storage/local_storage_service.dart';
import 'package:alvamind_library_two/app/utility/console_log.dart';
import 'package:alvamind_library_two/model/auth_model.dart';
import 'package:bangsatnyacintapertama/view/main/main_view.dart';
import 'package:bangsatnyacintapertama_graphql_client/gql_auth_service.dart';
import 'package:bangsatnyacintapertama_graphql_client/operations/generated/auth_login.graphql.dart';
import 'package:bangsatnyacintapertama_graphql_client/utils/gql_error_parser.dart';
import 'package:flutter/material.dart';

import '../../../view_model/main_view_model.dart';
import '../locator/service_locator.dart';

class AuthService {
  static Auth? auth;
  static bool renewingToken = false;

  static Mutation$AuthLogin$authLogin$user? user;

  static Future<void> initAuth() async {
    final authData = await LocalStorageService.readAuthData();
    final userData = await LocalStorageService.readData(LocalStorageKey.user);

    if (authData != null && userData != null) {
      auth = authData;
      user = Mutation$AuthLogin$authLogin$user.fromJson(json.decode(userData));
    } else {
      auth = null;
    }
  }

  static Future<String?> getToken() async {
    if (renewingToken) return null;

    var authData = await LocalStorageService.readAuthData();

    if (authData == null) {
      return null;
    }

    final aT = authData.accessToken;
    // final rT = authData.refreshToken;

    // if (Jwt.isExpired(aT)) {
    //   final renewedToken = await renewToken(rT);

    //   if (renewedToken == null) return null;

    //   authData.accessToken = renewedToken;

    //   await LocalStorageService.writeAuthData(authData);

    //   return 'Bearer $renewedToken';
    // }

    return 'Bearer $aT';
  }

  // static Future<String?> renewToken(String refreshToken) async {
  //   try {
  // renewingToken = true;

  // final result = await GraphQLService.client.query$RenewAccessToken(Options$Query$RenewAccessToken(
  //   fetchPolicy: FetchPolicy.networkOnly,
  //   variables: Variables$Query$RenewAccessToken(
  //     input: Input$RenewTokenInput(refreshToken: refreshToken),
  //   ),
  // ));

  // final resp = result.parsedData?.auth.renewToken;

  // if (resp is Fragment$RenewTokenSuccess) {
  //   return resp.newAccessToken;
  // } else {
  //   if (result.exception != null && result.exception!.graphqlErrors.isNotEmpty) {
  //     locator<AuthService>().logout();
  //   }
  // }
  //   } catch (e) {
  //     rethrow;
  //   } finally {
  //     renewingToken = false;
  //   }

  //   return null;
  // }

  static Future<String?> login({
    required String email,
    required String password,
  }) async {
    final res = await GqlAuthService.authLogin(email: email, password: password);

    if (res.parsedData?.authLogin != null && !res.hasException) {
      auth = Auth(
        accessToken: res.parsedData!.authLogin!.accessToken,
        refreshToken: "",
      );

      user = res.parsedData!.authLogin!.user;

      await LocalStorageService.writeAuthData(auth!);

      await LocalStorageService.writeData(
        LocalStorageKey.user,
        json.encode(user!.toJson()),
      );

      cl('[login].authLogin = ${res.parsedData!.authLogin?.toJson()}');
      return null;
    } else {
      cl('[login].error = ${gqlErrorParser(res)}');
      return gqlErrorParser(res);
    }
  }

  static Future<void> logOut(NavigatorState navigator) async {
    await LocalStorageService.deleteAllData();
    auth = null;

    final mainViewModel = locator<MainViewModel>();
    mainViewModel.resetState();
    navigator.pushNamedAndRemoveUntil(MainView.routeName, (route) => false);
    // mainViewModel.initMainView(navigator);
  }
}
