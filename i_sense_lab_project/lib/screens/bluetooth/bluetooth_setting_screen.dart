import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:getwidget/getwidget.dart';
import 'package:i_sense_lab_project/variables.dart';
import 'package:cool_alert/cool_alert.dart';

import '../../constants.dart';

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
