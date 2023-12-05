import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pixels/pixels.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

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
  late PixelImageController _controller2;

  late final Uri uriPhoto;
  late final WebSocketChannel channelPhoto;

  late final Uri uriLabel;
  late final WebSocketChannel channelLabel;

  @override
  void initState() {
    super.initState();
    uriPhoto = Uri.parse('ws://viaduct.proxy.rlwy.net:19322/ws');
    uriLabel = Uri.parse('ws://viaduct.proxy.rlwy.net:19322/label');

    channelPhoto = WebSocketChannel.connect(uriPhoto);
    channelLabel = WebSocketChannel.connect(uriLabel);

    _controller = PixelImageController(
      pixels: Uint8List(28 * 28).buffer.asByteData(),
      palette: const PixelPalette(colors: [
        Colors.white,
        Colors.black,
      ]),
      width: 28,
      height: 28,
    );

    _controller2 = PixelImageController(
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
    _controller2.dispose();
    channelPhoto.sink.close();
    channelLabel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(elevation: 0),
      body: Center(
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StreamBuilder(
                    stream: channelPhoto.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        _controller2.pixels =
                            Uint8List.fromList(snapshot.data as List<int>)
                                .buffer
                                .asByteData();
                        return PixelImage(
                          width: 28,
                          height: 28,
                          palette: const PixelPalette(
                            colors: [
                              Colors.white,
                              Colors.black,
                            ],
                          ),
                          pixels: _controller2.pixels,
                        );
                      } else {
                        return const SizedBox(
                          height: 200,
                        );
                      }
                    },
                  ),
                  StreamBuilder(
                    stream: channelLabel.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data.toString(),
                          style: const TextStyle(
                            fontSize: 100,
                          ),
                        );
                      } else {
                        return const SizedBox(
                          height: 200,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: Colors.grey[300],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PixelEditor(
                      controller: _controller,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.cleaning_services),
            onPressed: () {
              _controller.pixels = Uint8List(28 * 28).buffer.asByteData();
            },
          ),
          FloatingActionButton(
            child: const Icon(Icons.send_outlined),
            onPressed: () {
              final image = _controller.pixels;
              final bytes = image.buffer.asUint8List();

              channelPhoto.sink.add(bytes);
            },
          ),
        ],
      ),
    );
  }
}
