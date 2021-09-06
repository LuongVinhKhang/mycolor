// import 'package:flutter/material.dart';
// import 'package:rive/rive.dart';

// class PlayPauseView extends StatefulWidget {
//   final String state;

//   PlayPauseView({required this.state, Key? key}) : super(key: key);

//   @override
//   _PlayPauseViewState createState() => _PlayPauseViewState();
// }

// class _PlayPauseViewState extends State<PlayPauseView> {
//   late String _currentState;

//   late RiveAnimationController _controller;
//   late final RiveAnimationController _controllerPlay;
//   late final RiveAnimationController _controllerPause;

//   SMITrigger? _bump;

//   void _onRiveInit(Artboard artboard) {
//     final controller = StateMachineController.fromArtboard(artboard, 'ShowPlay');
//     artboard.addController(controller!);
//     _bump = controller.findInput<bool>('ShowPlay') as SMITrigger;
//   }

//   void _hitBump() => _bump?.fire();

//   @override
//   void initState() {
//     super.initState();
//     _currentState = widget.state;

//     _controllerPlay = OneShotAnimation(
//       'ShowPlay',
//       autoplay: true,
//     );

//     _controllerPause = OneShotAnimation(
//       'ShowPause',
//       autoplay: true ,
//     );

//     if (widget.state == 'ShowPlay') {
//       _controller = _controllerPlay;
//     } else {
//       _controller = _controllerPause;
//     }
//   }

//   _buildPlayPause() {
//     debugPrint('_buildPlayPause');
//     return RiveAnimation.asset(
//       'assets/rives/playpause.riv',
//       fit: BoxFit.fitWidth,
//       artboard: 'ArtBoard',
//       controllers: [_controller],
//       onInit: _onRiveInit,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(child: _buildPlayPause(),onTap: _hitBump,);
//   }
// }
