import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingManager extends StatefulWidget {
  const LoadingManager({super.key, required this.child, required this.isLoadlin});
  final Widget child;
  final bool isLoadlin;

  @override
  State<LoadingManager> createState() => _LoadingManagerState();
}

class _LoadingManagerState extends State<LoadingManager> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (widget.isLoadlin) ...[
          Container(
            color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
          ),
          Center(
            child: SpinKitWave(
              //Loading

              color: Colors.purple.withOpacity(0.7),
              size: 50.0,
              controller: AnimationController(
                vsync: this,
                duration: const Duration(milliseconds: 1200),
              ),
            ),
          )
        ]
      ],
    );
  }
}
