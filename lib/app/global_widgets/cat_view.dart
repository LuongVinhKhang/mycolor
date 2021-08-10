import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class CatView extends StatefulWidget {
  final String catState;

  CatView({required this.catState, Key? key}) : super(key: key);

  @override
  _CatViewState createState() => _CatViewState();
}

class _CatViewState extends State<CatView> {
  late String _currentState;

  late String _artboardCat;
  late final String _artboardCatWalk;
  late final String _artboardCatSit;
  late final String _artboardTree;

  late RiveAnimationController _controllerCat;
  late final RiveAnimationController _controllerCatWalk;
  late final RiveAnimationController _controllerCatSit;
  late final RiveAnimationController _controllerTree;

  void _toggleState() {
    if (_currentState == 'Walk') {
      setState(() {
        _currentState = 'Sit';
        _controllerCat = _controllerCatSit;
        _artboardCat = _artboardCatSit;
      });
    } else {
      setState(() {
        _currentState = 'Walk';
        _controllerCat = _controllerCatWalk;
        _artboardCat = _artboardCatWalk;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _currentState = widget.catState;
    _artboardCatWalk = 'Walk';
    _controllerCatWalk = SimpleAnimation(_artboardCatWalk);
    _artboardCatSit = 'Sit';
    _controllerCatSit = SimpleAnimation(_artboardCatSit);
    _artboardTree = 'Tree';
    _controllerTree = SimpleAnimation(_artboardTree);

    if (_currentState == 'Walk') {
      _controllerCat = _controllerCatWalk;
      _artboardCat = _artboardCatWalk;
    } else {
      _controllerCat = _controllerCatSit;
      _artboardCat = _artboardCatSit;
    }
  }

  Widget _buildCat() {
    print('_buildCat');
    return RiveAnimation.asset(
      'assets/rives/cat.riv',
      fit: BoxFit.contain,
      artboard: _artboardCat,
      controllers: [_controllerCat],
    );
  }

  Widget _buildTree() {
    print('_buildCat');
    return RiveAnimation.asset(
      'assets/rives/tree.riv',
      fit: BoxFit.fitWidth,
      artboard: _artboardTree,
      controllers: [_controllerTree],
    );
  }

  @override
  Widget build(BuildContext context) {
    print('object ' + _currentState);
    GestureDetector(
      // key: UniqueKey(),
      onTap: () => _toggleState(),
      child: Container(
        color: Colors.amber,
        // key: UniqueKey(),
        child: Stack(
          children: [
            Align(
              child: _buildTree(),
              alignment: Alignment.bottomRight,
            ),
            // _buildCat(),
          ],
        ),
      ),
    );
    // return  _buildTree();
    return _buildCat();
  }
}
