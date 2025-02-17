import 'dart:developer';

import 'package:auth_management/auth_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_andomie/core.dart';

import 'user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _signOut() {
    context.signOut<UserModel>();
  }

  void _updateUser() {
    context.updateAccount<UserModel>({
      UserKeys.i.name: "Omie ${RandomProvider.getInt(max: 50)}",
    });
  }

  void _biometricEnable(bool? value) {
    context.biometricEnable<UserModel>(value ?? false).then((value) {
      log("Biometric enable status : ${value.error}");
    });
  }

  void _biometricChange(BuildContext context) {
    context
        .addBiometric<UserModel>(
      config: const BiometricConfig(
        signInTitle: "Biometric",
        localizedReason: "Scan your face or fingerprint",
      ),
      callback: (value) => showDialog<BiometricStatus?>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Biometric permission from user!"),
            actions: [
              ElevatedButton(
                child: const Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context, BiometricStatus.initial);
                },
              ),
              ElevatedButton(
                child: const Text("Inactivate"),
                onPressed: () {
                  Navigator.pop(context, BiometricStatus.deactivated);
                },
              ),
              ElevatedButton(
                child: const Text("Activate"),
                onPressed: () {
                  Navigator.pop(context, BiometricStatus.activated);
                },
              ),
            ],
          );
        },
      ),
    )
        .then((value) {
      log("Add biometric status : ${value.error}");
    });
  }

  void _showSnackBar(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  void _showLoading(BuildContext context, bool loading) {}

  void _status(BuildContext context, AuthStatus status) {
    if (status.isUnauthenticated) {
      Navigator.pushNamedAndRemoveUntil(context, "startup", (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AuthObserver<UserModel>(
          onError: _showSnackBar,
          onMessage: _showSnackBar,
          onLoading: _showLoading,
          onStatus: _status,
          child: AuthConsumer<UserModel>(
            builder: (context, value) {
              return Container(
                padding: const EdgeInsets.all(32),
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.1),
                      ),
                      child: value?.photo == null
                          ? null
                          : Image.network(
                              value?.photo ?? "",
                              fit: BoxFit.cover,
                            ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      value?.name ?? "",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      value?.email ?? "",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      "Account created at ".join(
                        DateConverter.toRealtime(value?.timeMills ?? 0),
                      ),
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(height: 12),
                    Opacity(
                      opacity: value?.biometric.isInitial ?? false ? 0.5 : 1,
                      child: SwitchListTile.adaptive(
                        value: value?.isBiometric ?? false,
                        onChanged: _biometricEnable,
                        title: const Text("Biometric mode"),
                        contentPadding: const EdgeInsets.only(
                          left: 24,
                          right: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _updateUser,
                        child: const Text("Update"),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _biometricChange(context),
                        child: const Text("Add biometric"),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _signOut,
                        child: const Text("Logout"),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
