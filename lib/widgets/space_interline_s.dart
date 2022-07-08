import 'package:flutter/material.dart';

class SpaceInterlineS extends StatefulWidget {
  const SpaceInterlineS({Key? key}) : super(key: key);

  @override
  State<SpaceInterlineS> createState() => _SpaceInterlineSState();
}

class _SpaceInterlineSState extends State<SpaceInterlineS> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        SizedBox(
          height: 35.0,
        ),
      ],
    );
  }
}
