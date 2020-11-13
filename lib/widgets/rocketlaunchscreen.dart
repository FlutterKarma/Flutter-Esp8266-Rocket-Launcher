import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rocketlaucher/utility/utilitys.dart';

class Rocketlaunch extends StatefulWidget {
  final String selectedDevice;
  Rocketlaunch({Key key, this.selectedDevice})
      : super(
          key: key,
        );
  @override
  _RocketlaunchState createState() => _RocketlaunchState();
}

class _RocketlaunchState extends State<Rocketlaunch>
    with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _fireworkcontroller;
  void turnDeviceOn() async {
    setStatus(context, widget.selectedDevice, 1);
    snackBarMessage(context, " Launch initiated at ${widget.selectedDevice}");
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
    _fireworkcontroller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    _fireworkcontroller.dispose();
    super.dispose();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
            height: double.infinity,
            child: Lottie.asset(
              'assets/rocket.json',
              fit: BoxFit.fill,
              controller: _controller,
              onLoaded: (composition) {
                _controller.duration = composition.duration;
              },
            )),
        Container(
            alignment: Alignment.topCenter,
            child: Lottie.asset(
              'assets/diwali.json',
              controller: _fireworkcontroller,
              onLoaded: (composition) {
                _fireworkcontroller.duration = composition.duration;
              },
            )),
        Container(
            alignment: Alignment.topCenter,
            child: Lottie.asset(
              'assets/fireworks.json',
              controller: _fireworkcontroller,
              onLoaded: (composition) {
                _fireworkcontroller.duration = composition.duration;
              },
            )),
        Padding(
          padding: const EdgeInsets.all(50),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              setState(() {
                if (_controller.isAnimating) {
                } else {
                  _controller.forward();

                  turnDeviceOn();
                  _controller
                    ..addStatusListener((status) {
                      if (status == AnimationStatus.completed) {
                        setState(() {
                          _controller.reset();
                          _fireworkcontroller.forward();
                          _fireworkcontroller
                            ..addStatusListener((status) {
                              if (status == AnimationStatus.completed) {
                                setState(() {
                                  _fireworkcontroller.reset();
                                });
                              }
                            })
                            ..addStatusListener((state) => print('$state'));
                        });
                      }
                    })
                    ..addStatusListener((state) => print('$state'));
                }
              });
            },
            splashColor: Colors.blue,
            highlightColor: Colors.blue,
            child: Container(
              height: 100,
              width: 100,
              decoration:
                  BoxDecoration(color: Colors.white54, shape: BoxShape.circle),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Image.asset(
                  "assets/rocket.png",
                  color: _controller.isAnimating
                      ? Colors.transparent
                      : Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
