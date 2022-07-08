import 'package:flutter/material.dart';

class SpaceInterlineXs extends StatefulWidget {
  const SpaceInterlineXs({Key? key}) : super(key: key);

  @override
  State<SpaceInterlineXs> createState() => _SpaceInterlineXsState();
}

class _SpaceInterlineXsState extends State<SpaceInterlineXs> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        SizedBox(
          height: 15.0,
        ),
      ],
    );
  }
}
