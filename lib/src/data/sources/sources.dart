library sources;

import 'dart:convert';
import 'dart:core';

import 'package:data_management/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../../../core.dart';

part 'auth_data_source.dart';
part 'backup_data_source.dart';
part 'keep_data_source.dart';

extension _LocalExtension on Future<SharedPreferences> {
  Future<bool> input(
    String key,
    Map<String, dynamic>? value,
  ) async {
    try {
      final db = await this;
      var data = jsonEncode(value ?? {});
      if (data.isNotEmpty) {
        return db.setString(key, data);
      } else {
        return db.remove(key);
      }
    } catch (_) {
      return Future.error(_);
    }
  }

  Future<Map<String, dynamic>> output<T extends Entity>(String key) async {
    try {
      final db = await this;
      final raw = db.getString(key);
      final data = jsonDecode(raw ?? "{}");
      if (data is Map<String, dynamic>) {
        return data;
      } else {
        return {};
      }
    } catch (_) {
      return Future.error(_);
    }
  }
}
