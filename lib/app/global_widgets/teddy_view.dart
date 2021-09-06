import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class TeddyView extends StatefulWidget {
  final String teddyState;

  TeddyView({required this.teddyState, Key? key}) : super(key: key);

  @override
  _TeddyViewState createState() => _TeddyViewState();
}

class _TeddyViewState extends State<TeddyView> {
  late String _currentState;

  late String _artboardCat;
  late final String _artboardTeddy;

  late RiveAnimationController _controllerTeddy;
  late final RiveAnimationController _controllerTeddyFail;
  late final RiveAnimationController _controllerTeddySuccess;
  late final RiveAnimationController _controllerTeddyIdle;

  // void _toggleState() {
  //   if (_currentState == 'Idle') {
  //     setState(() {
  //       _currentState = 'Idle';
  //       _controllerTeddy = _controllerTeddyIdle;
  //       _artboardCat = _artboardTeddy;
  //     });
  //   } if(_currentState == 'Success'){
  //     setState(() {
  //       _currentState = 'Success';
  //       _controllerTeddy = _controllerTeddySuccess;
  //       _artboardCat = _artboardTeddy;
  //     });
  //   } else {
  //     setState(() {
  //       _currentState = 'Fail';
  //       _controllerTeddy = _controllerTeddyFail;
  //       _artboardCat = _artboardTeddy;
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    _currentState = widget.teddyState;

    _controllerTeddyIdle = SimpleAnimation("Idle");
    _controllerTeddySuccess = SimpleAnimation("Success");
    _controllerTeddyFail = SimpleAnimation("Fail");

    if (_currentState == 'Success') {
      _controllerTeddy = _controllerTeddySuccess;
    } else if (_currentState == 'Fail') {
      _controllerTeddy = _controllerTeddyFail;
    } else {
      _controllerTeddy = _controllerTeddyIdle;
    }
  }

  Widget _buildTeddy() {
    debugPrint('_buildCat');
    return RiveAnimation.asset(
      'assets/rives/teddy.riv',
      fit: BoxFit.contain,
      controllers: [_controllerTeddy],
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('object ' + _currentState);
    // GestureDetector(
    //   // key: UniqueKey(),
    //   onTap: () => _toggleState(),
    //   child: Container(
    //     color: Colors.amber,
    //     // key: UniqueKey(),
    //     child: Stack(
    //       children: [
    //         Align(
    //           child: _buildTree(),
    //           alignment: Alignment.bottomRight,
    //         ),
    //         // _buildCat(),
    //       ],
    //     ),
    //   ),
    // );
    // // return  _buildTree();
    return _buildTeddy();
  }
}
