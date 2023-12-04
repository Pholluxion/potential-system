import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pixels/pixels.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PixelPage(),
    ),
  );
}

class PixelPage extends StatefulWidget {
  const PixelPage({super.key});

  @override
  State<PixelPage> createState() => _PixelPageState();
}

class _PixelPageState extends State<PixelPage> {
  late PixelImageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PixelImageController(
      pixels: Uint8List(28 * 28).buffer.asByteData(),
      palette: const PixelPalette(colors: [
        Colors.white,
        Colors.black,
      ]),
      width: 28,
      height: 28,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Write a letter')),
      body: Center(
        child: SizedBox(
          child: PixelEditor(
            onSetPixel: (p0) {
              debugPrint('Pixel ${p0.tapDetails.x} set to ${p0.tapDetails.y}');
            },
            controller: _controller,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.delete),
        onPressed: () {
          _controller.pixels = Uint8List(28 * 28).buffer.asByteData();
        },
      ),
    );
  }
}
