import 'package:flutter/material.dart';
import 'package:i_sense_lab_project/Constants.dart';
import 'package:flutter_blue/flutter_blue.dart';

//全域變數的檔案夾

const kCurThemeColor = kPrimaryThemeColor;

//最多支援同時連接四個設備
FlutterBlue flutterBlue = FlutterBlue.instance;
List<BluetoothDevice> bluetoothDevices = new List<BluetoothDevice>(4);
