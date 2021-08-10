import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mycolor/app/modules/setting/controllers/timer_setting_controller.dart';

class TimerSettingView extends GetView<TimerSettingController> {
  _buildListTile() {
    return ListTile(
        leading: Icon(Icons.timer),
        title: TextButton(
          onPressed: () {},
          child: Text(''),
        ),
        trailing: IconButton(onPressed: () {}, icon: Icon(Icons.delete)));
  }

  _buildList() {
    return Obx(() => ListView.builder(itemBuilder: (context, index) {
          return _buildListTile();
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
          title: Text('Timer'),
          trailing: IconButton(onPressed: () {}, icon: Icon(Icons.add))),
      Placeholder(
        fallbackHeight: 300,
      )
    ]);
  }
}
