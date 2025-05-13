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
      borderRadius: 4,
      spacing: 5,
      runSpacing: 5,
      wheelDiameter: 155,
      subheading: Text(
        LocaleKeys.color_setting_add_popup_color_shade.tr,
        style: Theme.of(context).textTheme.subtitle1,
      ),
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

  void _onAddNewColor(ColorSettingSection section) async {
    controller.selectedColorToUpdate.value =
        controller.getLatestColorToAdd(section);

    if (!(await colorPickerDialog())) {
      debugPrint('dismissed ${controller.dialogSeletedColor}');
    } else {
      controller.addColor(section, controller.dialogSeletedColor.value);
    }
  }

  void _onColorIndicatorTap(
      Color currentColor, ColorSettingSection section, int index) async {
    controller.selectedColorSettingSection.value = section;
    controller.selectedSectionIndex.value = index;
    controller.selectedColorToUpdate.value = currentColor;

    if (!(await colorPickerDialog())) {
      debugPrint('dismissed ${controller.dialogSeletedColor}');
    } else {
      controller.setColor(controller.dialogSeletedColor.value);
    }
  }

  void _onRemovingColor(ColorSettingSection section, int index) {
    controller.removeColorByIndex(section, index);
  }

  Widget _buildTrailing(
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

  Widget _buildListTile(Color item, ColorSettingSection section, int index) {
    return ListTile(
        leading: const Icon(Icons.drag_handle),
        title: Text(ColorTools.nameThatColor(item)),
        subtitle: Text(
          ColorTools.materialNameAndCode(item),
        ),
        trailing: _buildTrailing(item, section, index));
  }

  Widget _buildDismissible(Color item, ColorSettingSection section, int index) {
    return Slidable(
      key: ValueKey(index * (section == ColorSettingSection.wave ? 2 : 3)),
      controller: slidableController,
      actionPane: const SlidableDrawerActionPane(),
      actionExtentRatio: 0.15,
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: LocaleKeys.color_setting_swipe_delete,
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => _onRemovingColor(section, index),
        ),
      ],
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
    );
  }

  Widget _buildColorList(ColorSettingSection section, List<Color> colors) {
    return Obx(
      () => colors.length == 1
          ? _buildListTile(colors[0], section, 0)
          : ReorderableListView.builder(
              shrinkWrap: true,
              itemCount: colors.length,
              itemBuilder: (context, index) {
                return _buildDismissible(colors[index], section, index);
              },
              onReorder: (oldIndex, newIndex) {
                controller.reorderColorByIndex(section, oldIndex, newIndex);
              },
            ),
    );
  }

  Widget _buildBackgroudColorList() {
    return _buildColorList(
        ColorSettingSection.background, controller.backgroudColors);
  }

  Widget _buildWaveColorList() {
    return _buildColorList(ColorSettingSection.wave, controller.waveColors);
  }

  Widget _buildWave() {
    return Obx(() => LiquidLinearProgressIndicator(
          // key: UniqueKey(),
          key: ValueKey(controller.waveColors.toString() +
              controller.backgroudColors.toString()),
          value: controller.currentPercentage.value,
          colors: controller.waveColors,
          backgroundColors: controller.backgroudColors,
          direction: Axis.vertical,
        ));
  }

  Widget _buildResetButton() {
    return CupertinoButton(
      onPressed: () {
        HapticFeedback.lightImpact();
        showCupertinoModalPopup<void>(
          context: context,
          builder: (context) => CupertinoActionSheet(
            actions: <CupertinoActionSheetAction>[
              CupertinoActionSheetAction(
                isDestructiveAction: true,
                onPressed: () {
                  controller.resetColorList(ColorSettingSection.wave);
                  Navigator.pop(context);
                },
                child: Text(LocaleKeys.color_setting_reset_wave_color.tr),
              ),
              CupertinoActionSheetAction(
                isDestructiveAction: true,
                onPressed: () {
                  controller.resetColorList(ColorSettingSection.background);
                  Navigator.pop(context);
                },
                child: Text(LocaleKeys.color_setting_reset_background_color.tr),
              ),
              CupertinoActionSheetAction(
                isDestructiveAction: true,
                isDefaultAction: true,
                onPressed: () {
                  controller.resetColorList(ColorSettingSection.wave);
                  controller.resetColorList(ColorSettingSection.background);
                  Navigator.pop(context);
                },
                child: Text(LocaleKeys.color_setting_reset_all.tr),
              )
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(LocaleKeys.color_setting_reset_cancel.tr),
            ),
          ),
        );
      },
      child: Text(LocaleKeys.color_setting_reset.tr,
          style: TextStyle(color: Colors.red)),
    );
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
              title: Text(LocaleKeys.color_setting_title.tr),
              centerTitle: true,
            ),
            body: SafeArea(
              child: Column(
                children: [
                  LimitedBox(
                    maxHeight: 300,
                    child: _buildWave(),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text(LocaleKeys.color_setting_wave.tr),
                            trailing: GestureDetector(
                              onTap: () =>
                                  _onAddNewColor(ColorSettingSection.wave),
                              child: const Icon(Icons.add),
                            ),
                          ),
                          _buildWaveColorList(),
                          ListTile(
                            title: Text(LocaleKeys.color_setting_background.tr),
                            trailing: GestureDetector(
                              onTap: () => _onAddNewColor(
                                  ColorSettingSection.background),
                              child: const Icon(Icons.add),
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
