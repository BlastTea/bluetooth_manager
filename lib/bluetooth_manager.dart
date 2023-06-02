import 'dart:async';

import 'package:flutter/services.dart';

import 'models/bluetooth_models.dart';

class BluetoothManager {
  static const MethodChannel _channel = MethodChannel('bluetooth_manager');

  /// get bluetooth state with response [BluetoothState]
  ///
  /// Response on, off, uknow
  Future<BluetoothState> getBluetoothState() async {
    final BluetoothState state;
    try {
      state = enumFromString(BluetoothState.values,
          await _channel.invokeMethod('getBluetoothState'));
    } catch (e) {
      rethrow;
    }
    return state;
  }

  /// get bluetooth Stream state with response [BluetoothState]
  /// you can pass timer in milliseconds the default is 1000
  ///
  /// getBluetoothStateStream(timer: 1000).listen((event) {
  ///   print(event);
  /// });
  ///
  /// Response on, off, uknow
  Stream<BluetoothState> getBluetoothStateStream({int timer = 1000}) async* {
    while (true) {
      await Future.delayed(Duration(milliseconds: timer < 500 ? 500 : timer));
      yield await getBluetoothState();
    }
  }

  /// enable bluetooth
  ///
  /// and can return the bluetooth action response [ActionResponse]
  /// bluetoothIsOn, bluetoothIsOff, bluetoothAlreadyOn, bluetoothAlreadyOff, responseError
  Future<ActionResponse> enableBluetooth() async {
    final ActionResponse actionResponse;
    try {
      actionResponse = enumFromString(ActionResponse.values,
          await _channel.invokeMethod('enableBluetooth'));
    } catch (e) {
      rethrow;
    }
    return actionResponse;
  }

  /// disable bluetooth
  ///
  /// and can return the bluetooth action response [ActionResponse]
  /// bluetoothIsOn, bluetoothIsOff, bluetoothAlreadyOn, bluetoothAlreadyOff, responseError
  Future<ActionResponse> disableBluetooth() async {
    final ActionResponse actionResponse;
    try {
      actionResponse = enumFromString(ActionResponse.values,
          await _channel.invokeMethod('disableBluetooth'));
    } catch (e) {
      rethrow;
    }
    return actionResponse;
  }
}
