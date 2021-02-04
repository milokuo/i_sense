import 'dart:math' show Random;

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:getwidget/getwidget.dart';
import 'package:i_sense_lab_project/variables.dart';
import 'package:cool_alert/cool_alert.dart';

import '../../constants.dart';
import 'components/widget.dart';

class BluetootheSettingScreen extends StatefulWidget {
  @override
  _BluetootheSettingScreenState createState() =>
      _BluetootheSettingScreenState();
}

class _BluetootheSettingScreenState extends State<BluetootheSettingScreen> {
  List<String> scannedResults = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Find Devices'),
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            FlutterBlue.instance.startScan(timeout: Duration(seconds: 4)),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              StreamBuilder<List<BluetoothDevice>>(
                stream: Stream.periodic(Duration(seconds: 2))
                    .asyncMap((_) => FlutterBlue.instance.connectedDevices),
                initialData: [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data
                      .map((d) => ListTile(
                            title: Text(d.name),
                            subtitle: Text(d.id.toString()),
                            trailing: StreamBuilder<BluetoothDeviceState>(
                              stream: d.state,
                              initialData: BluetoothDeviceState.disconnected,
                              builder: (c, snapshot) {
                                if (snapshot.data ==
                                    BluetoothDeviceState.connected) {
                                  return RaisedButton(
                                    child: Text('OPEN'),
                                    onPressed: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DeviceScreen(device: d))),
                                  );
                                }
                                return Text(snapshot.data.toString());
                              },
                            ),
                          ))
                      .toList(),
                ),
              ),
              StreamBuilder<List<ScanResult>>(
                stream: FlutterBlue.instance.scanResults,
                initialData: [],
                builder: (c, snapshot) => Column(
                  children: snapshot.data
                      .where((s) =>
                          s.device.name.contains("NAXSEN") ||
                          s.device.name.contains("Rabboni"))
                      .map(
                        (r) => ScanResultTile(
                          result: r,
                          onTap: () => Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            r.device.connect();
                            return DeviceScreen(device: r.device);
                          })),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: StreamBuilder<bool>(
        stream: FlutterBlue.instance.isScanning,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data) {
            return FloatingActionButton(
              child: Icon(Icons.stop),
              onPressed: () => FlutterBlue.instance.stopScan(),
              backgroundColor: Colors.red,
            );
          } else {
            return FloatingActionButton(
                child: Icon(Icons.search),
                onPressed: () => FlutterBlue.instance
                    .startScan(timeout: Duration(seconds: 4)));
          }
        },
      ),
    )
        // child: Scaffold(
        //   body: Padding(
        //     padding: EdgeInsets.symmetric(
        //       vertical: kDefaultPadding,
        //       horizontal: kDefaultPadding,
        //     ),
        //     child: ListView(
        //       children: [buildCard()],
        //     ),
        //   ),
        // ),
        );
  }

  Widget buildCard() {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2,
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        child: SizedBox(
          width: size.width * 0.8,
          height: size.height * 0.20,
          child: Row(
            children: [
              SizedBox(
                width: size.width * 0.03,
              ),
              Image.asset("images/main_pics/naxsen300_resized.png"),
              Column(
                children: [],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildCards() {
    return [
      GestureDetector(
        onTap: () {
          scannedResults.clear();
          flutterBlue.stopScan();
          flutterBlue
              .startScan(timeout: Duration(seconds: 4))
              .timeout(Duration(seconds: 4))
              .then((value) => flutterBlue.stopScan());
          var scanSubscription = flutterBlue.scanResults.listen(
            (results) {
              for (ScanResult r in results) {
                if (r.device.name.contains("NAXSEN") &&
                    !scannedResults.contains(r.device.name)) {
                  scannedResults.add(r.device.name);
                  CoolAlert.show(
                    context: context,
                    type: CoolAlertType.confirm,
                    text: "已找到${r.device.name}，是否進行連線",
                    confirmBtnText: "確認",
                    cancelBtnText: "取消",
                    onConfirmBtnTap: () => r.device
                        .connect()
                        .then((value) => Navigator.pop(context)),
                  );
                }
              }
            },
          );
          close() {
            scanSubscription.cancel();
          }
        },
        child: GFCard(
          buttonBar: GFButtonBar(
            alignment: WrapAlignment.spaceAround,
            children: [
              GFIconButton(
                icon: Icon(Icons.adjust),
                onPressed: () {},
              ),
              GFIconButton(
                icon: Icon(Icons.adjust),
                onPressed: () {},
              ),
            ],
          ),
          content: Text(
            "一號",
            style: TextStyle(
              fontSize: 22,
            ),
          ),
        ),
      ),
      GestureDetector(
        child: GFCard(),
      ),
      GestureDetector(
        child: GFCard(),
      ),
      GestureDetector(
        child: GFCard(),
      ),
    ];
  }
}

class DeviceScreen extends StatelessWidget {
  const DeviceScreen({Key key, this.device}) : super(key: key);

  final BluetoothDevice device;

  List<int> _getRandomBytes() {
    return [0, 0, 0, 0];
  }

  List<Widget> _buildServiceTiles(List<BluetoothService> services) {
    return services
        .where((s) => s.uuid.toString().substring(4, 8) == "1600")
        .map(
          (s) => ServiceTile(
            service: s,
            characteristicTiles: s.characteristics
                .where((c) => c.uuid.toString().substring(4, 8) == "1601")
                .map(
                  (c) => CharacteristicTile(
                    characteristic: c,
                    onReadPressed: () {
                      if (c.properties.read) c.read();
                    },
                    onWritePressed: () async {
                      await c.write(_getRandomBytes(), withoutResponse: true);
                      await c.read();
                    },
                    onNotificationPressed: () async {
                      await c.setNotifyValue(!c.isNotifying);
                      if (c.properties.read) await c.read();
                    },
                    descriptorTiles: c.descriptors
                        .map(
                          (d) => DescriptorTile(
                            descriptor: d,
                            onReadPressed: () => d.read(),
                            onWritePressed: () => d.write(_getRandomBytes()),
                          ),
                        )
                        .toList(),
                  ),
                )
                .toList(),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(device.name),
        actions: <Widget>[
          StreamBuilder<BluetoothDeviceState>(
            stream: device.state,
            initialData: BluetoothDeviceState.connecting,
            builder: (c, snapshot) {
              VoidCallback onPressed;
              String text;
              switch (snapshot.data) {
                case BluetoothDeviceState.connected:
                  onPressed = () => device.disconnect();
                  text = 'DISCONNECT';
                  break;
                case BluetoothDeviceState.disconnected:
                  onPressed = () => device.connect();
                  text = 'CONNECT';
                  break;
                default:
                  onPressed = null;
                  text = snapshot.data.toString().substring(21).toUpperCase();
                  break;
              }
              return FlatButton(
                  onPressed: onPressed,
                  child: Text(
                    text,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .button
                        .copyWith(color: Colors.white),
                  ));
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            StreamBuilder<BluetoothDeviceState>(
              stream: device.state,
              initialData: BluetoothDeviceState.connecting,
              builder: (c, snapshot) => ListTile(
                leading: (snapshot.data == BluetoothDeviceState.connected)
                    ? Icon(Icons.bluetooth_connected)
                    : Icon(Icons.bluetooth_disabled),
                title: Text(
                    'Device is ${snapshot.data.toString().split('.')[1]}.'),
                subtitle: Text('${device.id}'),
                trailing: StreamBuilder<bool>(
                  stream: device.isDiscoveringServices,
                  initialData: false,
                  builder: (c, snapshot) => IndexedStack(
                    index: snapshot.data ? 1 : 0,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () => device.discoverServices(),
                      ),
                      IconButton(
                        icon: SizedBox(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.grey),
                          ),
                          width: 18.0,
                          height: 18.0,
                        ),
                        onPressed: null,
                      )
                    ],
                  ),
                ),
              ),
            ),
            StreamBuilder<int>(
              stream: device.mtu,
              initialData: 0,
              builder: (c, snapshot) => ListTile(
                title: Text('MTU Size'),
                subtitle: Text('${snapshot.data} bytes'),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => device.requestMtu(223),
                ),
              ),
            ),
            StreamBuilder<List<BluetoothService>>(
              stream: device.services,
              initialData: [],
              builder: (c, snapshot) {
                return Column(
                  children: _buildServiceTiles(snapshot.data),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
