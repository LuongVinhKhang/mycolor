import 'dart:io';

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';
import 'package:mycolor/app/data/enums.dart';
import 'package:mycolor/app/global_widgets/liquid_linear_progress_indicator.dart';
import 'package:mycolor/app/modules/color_setting/controllers/color_setting_controller.dart';
import 'package:mycolor/generated/locales.g.dart';

class ColorSettingView extends GetView<ColorSettingController> {
  final context = Get.context!;
  final SlidableController slidableController = SlidableController();

  Future<bool> colorPickerDialog() async {
    return ColorPicker(
      // Use the dialogPickerColor as start color.
      color: controller.selectedColorToUpdate.value,
      // Update the dialogPickerColor using the callback.
      onColorChanged: (color) {
        controller.dialogSeletedColor.value = color;
      },
      width: 40,
      height: 40,
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      // heading: Text(
      //   'Select color',
      //   style: Theme.of(context).textTheme.subtitle1,
      // ),
      subheading: Text(
        'Select color shade',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      // wheelSubheading: Text(
      //   'Selected color and its shades',
      //   style: Theme.of(context).textTheme.subtitle1,
      // ),
      showMaterialName: true,
      showColorName: true,
      showColorCode: true,
      copyPasteBehavior: const ColorPickerCopyPasteBehavior(
        longPressMenu: true,
      ),
      materialNameTextStyle: Theme.of(context).textTheme.caption,
      colorNameTextStyle: Theme.of(context).textTheme.caption,
      colorCodeTextStyle: Theme.of(context).textTheme.caption,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: true,
        ColorPickerType.accent: true,
        ColorPickerType.bw: false,
        ColorPickerType.custom: false,
        ColorPickerType.wheel: true,
      },
      enableOpacity: true,
      actionButtons: const ColorPickerActionButtons(
          okButton: true, closeButton: true, dialogActionButtons: false),
    ).showPickerDialog(
      context,
      constraints:
          const BoxConstraints(minHeight: 460, minWidth: 300, maxWidth: 320),
    );
  }

  _onAddNewColor(ColorSettingSection section) async {
    controller.selectedColorToUpdate.value =
        controller.getLatestColorToAdd(section);

    if (!(await colorPickerDialog())) {
      print('dismissed' + controller.dialogSeletedColor.toString());
    } else {
      controller.addColor(section, controller.dialogSeletedColor.value);
    }
  }

  _onColorIndicatorTap(
      Color currentColor, ColorSettingSection section, int index) async {
    controller.selectedColorSettingSection.value = section;
    controller.selectedSectionIndex.value = index;
    controller.selectedColorToUpdate.value = currentColor;

    if (!(await colorPickerDialog())) {
      print('dismissed' + controller.dialogSeletedColor.toString());
    } else {
      controller.setColor(controller.dialogSeletedColor.value);
    }
  }

  _onRemovingColor(ColorSettingSection section, int index) {
    controller.removeColorByIndex(section, index);
  }

  _onEmptyColorListCheck() {
    if (controller.backgroudColors.isEmpty || controller.waveColors.isEmpty) {
      _displayConfirmEmptyColorDialog();
      return true;
    }
    return false;
  }

  _onPreviewOnNewPage() {}

  _buildTrailing(
    Color item,
    ColorSettingSection section,
    int index,
  ) {
    return GestureDetector(
        onTap: () => _onColorIndicatorTap(item, section, index),
        child: ColorIndicator(
          width: 44,
          height: 44,
          borderRadius: 4,
          color: item,
          onSelectFocus: false,
          borderColor: Colors.teal,
        ));
  }

  _buildListTile(Color item, ColorSettingSection section, int index) {
    return ListTile(
        leading: Icon(Icons.drag_handle),
        title: Text('${ColorTools.nameThatColor(item)}'),
        subtitle: Text(
          '${ColorTools.materialNameAndCode(item)}',
        ),
        trailing: _buildTrailing(item, section, index));
  }

  _buildDismissible(Color item, ColorSettingSection section, int index) {
    return Slidable(
      key: ValueKey(index * (section == ColorSettingSection.wave ? 2 : 3)),
      controller: slidableController,
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.15,
      // ignore: todo
      // TODO: exception related to key
      // dismissal: SlidableDismissal(
      //   child: SlidableDrawerDismissal(),
      //   key: UniqueKey(),
      //   onDismissed: (actionType) {
      //     if (actionType == SlideActionType.secondary) {
      //       controller.removeColorByIndex(section, index);
      //       // _onRemovingColor(section, index);
      //     }
      //   },
      //   dismissThresholds: <SlideActionType, double>{
      //     SlideActionType.primary: 1.0
      //   },
      // ),
      child: _buildListTile(item, section, index),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => _onRemovingColor(section, index),
        ),
      ],
    );
  }

  _buildColorList(ColorSettingSection section, List<Color> colors) {
    return Obx(
      () => colors.length == 1
          ? _buildListTile(colors[0], section, 0)
          : ReorderableListView.builder(
              shrinkWrap: true,
              itemCount: colors.length,
              itemBuilder: (context, index) {
                return _buildDismissible(colors[index], section, index);
              },
              onReorder: (int oldIndex, int newIndex) {
                controller.reorderColorByIndex(section, oldIndex, newIndex);
              },
            ),
    );
  }

  _buildBackgroudColorList() {
    return _buildColorList(
        ColorSettingSection.background, controller.backgroudColors);
  }

  _buildWaveColorList() {
    return _buildColorList(ColorSettingSection.wave, controller.waveColors);
  }

  _buildWave() {
    return Obx(() => LiquidLinearProgressIndicator(
          key: UniqueKey(),
          value: controller.currentPercentage.value,
          colors: controller.waveColors,
          backgroundColors: controller.backgroudColors,
          direction: Axis.vertical,
        ));
  }

  _buildResetButton() {
    return CupertinoButton(
      onPressed: () {
        HapticFeedback.lightImpact();
        showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) => CupertinoActionSheet(
            actions: <CupertinoActionSheetAction>[
              CupertinoActionSheetAction(
                isDestructiveAction: true,
                child: const Text('Reset wave color'),
                onPressed: () {
                  controller.resetColorList(ColorSettingSection.wave);
                  Navigator.pop(context);
                },
              ),
              CupertinoActionSheetAction(
                isDestructiveAction: true,
                child: const Text('Reset background color'),
                onPressed: () {
                  controller.resetColorList(ColorSettingSection.background);
                  Navigator.pop(context);
                },
              ),
              CupertinoActionSheetAction(
                isDestructiveAction: true,
                isDefaultAction: true,
                child: const Text('Reset all'),
                onPressed: () {
                  controller.resetColorList(ColorSettingSection.wave);
                  controller.resetColorList(ColorSettingSection.background);
                  Navigator.pop(context);
                },
              )
            ],
            cancelButton: CupertinoActionSheetAction(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
      child: const Text('Reset', style: TextStyle(color: Colors.red)),
    );
  }

  _displayConfirmEmptyColorDialogIOS() {
    showDialog(
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        title: new Text(LocaleKeys.color_setting_dialog_empty_color_alert.tr),
        content: new Text(LocaleKeys
            .color_setting_dialog_empty_color_you_removed_all_color.tr),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child:
                new Text(LocaleKeys.color_setting_dialog_empty_color_cancel.tr),
            onPressed: () {
              Get.back();
            },
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            child: new Text(LocaleKeys.color_setting_dialog_empty_color_ok.tr),
            onPressed: () {
              Get.back();
              Get.back();
            },
          )
        ],
      ),
    );
  }

  _displayConfirmEmptyColorDialogAndroid() {
    showDialog(
      context: context,
      builder: (BuildContext context) => new AlertDialog(
        title: new Text(LocaleKeys.color_setting_dialog_empty_color_alert.tr),
        content: new Text(LocaleKeys.color_setting_dialog_empty_color_alert.tr),
        actions: [
          TextButton(
            child: Text(LocaleKeys.color_setting_dialog_empty_color_ok.tr),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            child: Text(LocaleKeys.color_setting_dialog_empty_color_cancel.tr),
            onPressed: () {
              Get.back();
              Get.back();
            },
          )
        ],
      ),
    );
  }

  _displayConfirmEmptyColorDialog() {
    if (Platform.isIOS) {
      _displayConfirmEmptyColorDialogIOS();
    } else if (Platform.isAndroid) {
      _displayConfirmEmptyColorDialogAndroid()();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          controller.saveColorToStorage();
          return true;
        },
        child: ThemeSwitchingArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text(LocaleKeys.color_setting_dialog_empty_color_alert.tr),
              centerTitle: true,
            ),
            body: SafeArea(
              child: Column(
                children: [
                  LimitedBox(
                    child: _buildWave(),
                    maxHeight: 300,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text('Wave'),
                            trailing: GestureDetector(
                              onTap: () =>
                                  _onAddNewColor(ColorSettingSection.wave),
                              child: Icon(Icons.add),
                            ),
                          ),
                          _buildWaveColorList(),
                          ListTile(
                            title: Text('Background'),
                            trailing: GestureDetector(
                              onTap: () => _onAddNewColor(
                                  ColorSettingSection.background),
                              child: Icon(Icons.add),
                            ),
                          ),
                          _buildBackgroudColorList(),
                          Center(
                            child: _buildResetButton(),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
