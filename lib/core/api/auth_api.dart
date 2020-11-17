import 'package:flutter/material.dart';
import 'package:kedatonkomputer/core/api/main_api.dart';
import 'package:kedatonkomputer/core/models/account_model.dart';

class AuthApi extends MainApi {
  
  Future<AccountModel> login({
    @required String username,
    @required String password
  }) async {
    try {
      final response = await postRequest(
        url: "$host/user/login",
        body: {
          "email": username,
          "password": password
        }
      );
      return accountModelFromMap(response);
    } catch (error) {
      throw error;
    }
  }
  
  Future<AccountModel> register({
    @required AccountModel data
  }) async {
    try {
      final response = await postRequest(
        url: "$host/user/register",
        body: data.toMapForRegister()
      );
      return accountModelFromMap(response);
    } catch (error) {
      throw error;
    }
  }
  
  Future<AccountModel> getProfile() async {
    try {
      final response = await getRequest(
        url: "$host/user/me",
        useAuth: true
      );
      return accountModelFromMap(response);
    } catch (error) {
      throw error;
    }
  }
  
  Future<AccountModel> editProfile({
    @required AccountModel data
  }) async {
    try {
      final response = await patchRequest(
        url: "$host/user/me",
        body: data.toMapForEditProfile(),
        useAuth: true
      );
      return accountModelFromMap(response);
    } catch (error) {
      throw error;
    }
  }
  
  Future<AccountModel> editPassword({
    @required String password,
    @required String oldPassword
  }) async {
    try {
      final response = await patchRequest(
        url: "$host/user/me/password",
        body: {
          "password" : password,
          "oldPassword" : oldPassword
        },
        useAuth: true
      );
      return accountModelFromMap(response);
    } catch (error) {
      throw error;
    }
  }
  
}