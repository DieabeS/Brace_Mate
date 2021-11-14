import 'dart:io';
import 'dart:typed_data';

import 'package:brace_mate/src/enums/teeth.dart';
import 'package:brace_mate/src/widgets/braces_painter.dart';
import 'package:brace_mate/src/widgets/svg_color_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import '../../size.config.dart';

class BracesScreen extends StatefulWidget {
  const BracesScreen({Key? key}) : super(key: key);

  @override
  _BracesScreenState createState() => _BracesScreenState();
}

class _BracesScreenState extends State<BracesScreen> {
  final controller = ScreenshotController();
  List<String> svgColorCodes = List.filled(20, '#default.#bdd4de');
  List<String> visibles = List.filled(20, 'hidden');
  List<String> finalColors = List.filled(20, '');
  TextStyle style = TextStyle(fontSize: getProportionateScreenWidth(10), color: Colors.white);
  var rtl = true;
  var ttb = true;
  var teeth = Teeth.Middle;
  var random = true;
  @override
  void initState() {
    for (var i = 0; i < svgColorCodes.length; i++) {
      finalColors[i] = svgColorCodes[i].split('.')[1].split(':')[0];
    }
    super.initState();
  }

  Future<void> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();
    final time = DateTime.now().toIso8601String().replaceAll('.', '-').replaceAll(':', '-');
    final name = 'screenshot_$time';
    await ImageGallerySaver.saveImage(bytes, name: name);
    // return result['filepath'];
  }

  Future<void> saveAnadShareImage(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/screenshot.png');
    image.writeAsBytesSync(bytes);
    await Share.shareFiles([image.path]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        actions: [
          GestureDetector(
              onTap: () async {
                setState(() {
                  for (var i = 0; i < visibles.length; i++) {
                    visibles[i] = 'hidden';
                  }
                });
                await Future.delayed(Duration(seconds: 1));

                final image = await controller.capture();
                if (image == null) return;
                await saveImage(image);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                    'Image saved!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: getProportionateScreenWidth(18)),
                  ),
                  backgroundColor: Colors.purple,
                  duration: Duration(seconds: 2),
                ));
              },
              child: Padding(
                padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                child: Icon(Icons.save_alt),
              )),
          GestureDetector(
              onTap: () async {
                setState(() {
                  for (var i = 0; i < visibles.length; i++) {
                    visibles[i] = 'hidden';
                  }
                });
                await Future.delayed(Duration(seconds: 1));

                final image = await controller.capture();
                if (image == null) return;
                await saveAnadShareImage(image);
              },
              child: Padding(
                padding: EdgeInsets.all(getProportionateScreenWidth(8)),
                child: Icon(Icons.ios_share),
              )),
        ],
        title: Text(
          'Brace Mate',
          style: TextStyle(fontSize: getProportionateScreenWidth(15)),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenWidth(20)),
            Stack(
              children: [
                Container(
                    height: getProportionateScreenWidth(190),
                    width: double.infinity,
                    child: Screenshot(controller: controller, child: BracesPainter(visibles: visibles, colors: finalColors))),
                Positioned(
                  top: getProportionateScreenWidth(56),
                  left: getProportionateScreenWidth(0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (visibles[0] == "hidden") {
                          visibles[0] = "visible";
                        } else {
                          visibles[0] = 'hidden';
                        }
                      });
                    },
                    child: Container(
                      width: getProportionateScreenWidth(15),
                      height: getProportionateScreenWidth(30),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: getProportionateScreenWidth(52),
                  left: getProportionateScreenWidth(15),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (visibles[1] == "hidden") {
                          visibles[1] = "visible";
                        } else {
                          visibles[1] = 'hidden';
                        }
                      });
                    },
                    child: Container(
                      width: getProportionateScreenWidth(20),
                      height: getProportionateScreenWidth(30),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: getProportionateScreenWidth(53),
                  left: getProportionateScreenWidth(36),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (visibles[2] == "hidden") {
                          visibles[2] = "visible";
                        } else {
                          visibles[2] = 'hidden';
                        }
                      });
                    },
                    child: Container(
                      width: getProportionateScreenWidth(30),
                      height: getProportionateScreenWidth(30),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: getProportionateScreenWidth(53),
                  left: getProportionateScreenWidth(83),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (visibles[3] == "hidden") {
                          visibles[3] = "visible";
                        } else {
                          visibles[3] = 'hidden';
                        }
                      });
                    },
                    child: Container(
                      width: getProportionateScreenWidth(32),
                      height: getProportionateScreenWidth(32),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: getProportionateScreenWidth(50),
                  left: getProportionateScreenWidth(145),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (visibles[4] == "hidden") {
                          visibles[4] = "visible";
                        } else {
                          visibles[4] = 'hidden';
                        }
                      });
                    },
                    child: Container(
                      width: getProportionateScreenWidth(34),
                      height: getProportionateScreenWidth(34),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: getProportionateScreenWidth(50),
                  left: getProportionateScreenWidth(210),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (visibles[5] == "hidden") {
                          visibles[5] = "visible";
                        } else {
                          visibles[5] = 'hidden';
                        }
                      });
                    },
                    child: Container(
                      width: getProportionateScreenWidth(34),
                      height: getProportionateScreenWidth(34),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: getProportionateScreenWidth(51),
                  left: getProportionateScreenWidth(267),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (visibles[6] == "hidden") {
                          visibles[6] = "visible";
                        } else {
                          visibles[6] = 'hidden';
                        }
                      });
                    },
                    child: Container(
                      width: getProportionateScreenWidth(33),
                      height: getProportionateScreenWidth(33),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: getProportionateScreenWidth(52),
                  left: getProportionateScreenWidth(310),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (visibles[7] == "hidden") {
                          visibles[7] = "visible";
                        } else {
                          visibles[7] = 'hidden';
                        }
                      });
                    },
                    child: Container(
                      width: getProportionateScreenWidth(30),
                      height: getProportionateScreenWidth(32),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: getProportionateScreenWidth(58),
                  left: getProportionateScreenWidth(340),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (visibles[8] == "hidden") {
                          visibles[8] = "visible";
                        } else {
                          visibles[8] = 'hidden';
                        }
                      });
                    },
                    child: Container(
                      width: getProportionateScreenWidth(22),
                      height: getProportionateScreenWidth(28),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: getProportionateScreenWidth(60),
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (visibles[9] == "hidden") {
                          visibles[9] = "visible";
                        } else {
                          visibles[9] = 'hidden';
                        }
                      });
                    },
                    child: Container(
                      width: getProportionateScreenWidth(14),
                      height: getProportionateScreenWidth(26),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: getProportionateScreenWidth(93),
                  left: getProportionateScreenWidth(14),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (visibles[10] == "hidden") {
                          visibles[10] = "visible";
                        } else {
                          visibles[10] = 'hidden';
                        }
                      });
                    },
                    child: Container(
                      width: getProportionateScreenWidth(20),
                      height: getProportionateScreenWidth(27),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: getProportionateScreenWidth(103),
                  left: getProportionateScreenWidth(34),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (visibles[11] == "hidden") {
                          visibles[11] = "visible";
                        } else {
                          visibles[11] = 'hidden';
                        }
                      });
                    },
                    child: Container(
                      width: getProportionateScreenWidth(23),
                      height: getProportionateScreenWidth(28),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: getProportionateScreenWidth(107),
                  left: getProportionateScreenWidth(63),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (visibles[12] == "hidden") {
                          visibles[12] = "visible";
                        } else {
                          visibles[12] = 'hidden';
                        }
                      });
                    },
                    child: Container(
                      width: getProportionateScreenWidth(28),
                      height: getProportionateScreenWidth(28),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: getProportionateScreenWidth(104),
                  left: getProportionateScreenWidth(108),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (visibles[13] == "hidden") {
                          visibles[13] = "visible";
                        } else {
                          visibles[13] = 'hidden';
                        }
                      });
                    },
                    child: Container(
                      width: getProportionateScreenWidth(30),
                      height: getProportionateScreenWidth(30),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: getProportionateScreenWidth(104),
                  left: getProportionateScreenWidth(150),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (visibles[14] == "hidden") {
                          visibles[14] = "visible";
                        } else {
                          visibles[14] = 'hidden';
                        }
                      });
                    },
                    child: Container(
                      width: getProportionateScreenWidth(33),
                      height: getProportionateScreenWidth(33),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: getProportionateScreenWidth(105),
                  left: getProportionateScreenWidth(200),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (visibles[15] == "hidden") {
                          visibles[15] = "visible";
                        } else {
                          visibles[15] = 'hidden';
                        }
                      });
                    },
                    child: Container(
                      width: getProportionateScreenWidth(33),
                      height: getProportionateScreenWidth(33),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: getProportionateScreenWidth(105),
                  left: getProportionateScreenWidth(245),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (visibles[16] == "hidden") {
                          visibles[16] = "visible";
                        } else {
                          visibles[16] = 'hidden';
                        }
                      });
                    },
                    child: Container(
                      width: getProportionateScreenWidth(33),
                      height: getProportionateScreenWidth(33),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: getProportionateScreenWidth(103),
                  left: getProportionateScreenWidth(288),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (visibles[17] == "hidden") {
                          visibles[17] = "visible";
                        } else {
                          visibles[17] = 'hidden';
                        }
                      });
                    },
                    child: Container(
                      width: getProportionateScreenWidth(30),
                      height: getProportionateScreenWidth(30),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: getProportionateScreenWidth(99),
                  left: getProportionateScreenWidth(319),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (visibles[18] == "hidden") {
                          visibles[18] = "visible";
                        } else {
                          visibles[18] = 'hidden';
                        }
                      });
                    },
                    child: Container(
                      width: getProportionateScreenWidth(23),
                      height: getProportionateScreenWidth(28),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: getProportionateScreenWidth(99),
                  left: getProportionateScreenWidth(342),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (visibles[19] == "hidden") {
                          visibles[19] = "visible";
                        } else {
                          visibles[19] = 'hidden';
                        }
                      });
                    },
                    child: Container(
                      width: getProportionateScreenWidth(18),
                      height: getProportionateScreenWidth(27),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenWidth(20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.4), borderRadius: BorderRadius.circular(getProportionateScreenWidth(5))),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        for (var i = 0; i < visibles.length; i++) {
                          visibles[i] = 'hidden';
                        }
                      });
                    },
                    child: Container(
                        height: getProportionateScreenWidth(40),
                        width: getProportionateScreenWidth(40),
                        child: SvgPicture.asset(
                          'assets/none.svg',
                          fit: BoxFit.contain,
                        )),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.4), borderRadius: BorderRadius.circular(getProportionateScreenWidth(5))),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        for (var i = 0; i < visibles.length; i++) {
                          visibles[i] = 'hidden';

                          if (visibles[i] == "hidden") {
                            visibles[i] = "visible";
                          } else {
                            visibles[i] = 'hidden';
                          }
                        }
                      });
                    },
                    child: Container(
                        height: getProportionateScreenWidth(40),
                        width: getProportionateScreenWidth(40),
                        child: SvgPicture.asset(
                          'assets/all.svg',
                          fit: BoxFit.contain,
                        )),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.4), borderRadius: BorderRadius.circular(getProportionateScreenWidth(5))),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        for (var i = 0; i < visibles.length; i++) {
                          visibles[i] = 'hidden';
                          if (ttb) {
                            if (i < 10) {
                              if (visibles[i] == "hidden") {
                                visibles[i] = "visible";
                              } else {
                                visibles[i] = 'hidden';
                              }
                            }
                          } else {
                            if (i > 10) {
                              if (visibles[i] == "hidden") {
                                visibles[i] = "visible";
                              } else {
                                visibles[i] = 'hidden';
                              }
                            }
                          }
                        }
                        ttb = !ttb;
                      });
                    },
                    child: Container(
                        height: getProportionateScreenWidth(40),
                        width: getProportionateScreenWidth(40),
                        child: SvgPicture.asset(
                          ttb ? 'assets/topall.svg' : 'assets/botall.svg',
                          fit: BoxFit.contain,
                        )),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.4), borderRadius: BorderRadius.circular(getProportionateScreenWidth(5))),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (!rtl) {
                          for (var i = 0; i < visibles.length; i++) {
                            visibles[i] = 'hidden';
                          }
                          for (var i = 0; i < 5; i++) {
                            visibles[i] = "visible";
                          }
                          for (var i = 10; i < 15; i++) {
                            visibles[i] = "visible";
                          }
                        } else {
                          for (var i = 0; i < visibles.length; i++) {
                            visibles[i] = 'hidden';
                          }
                          for (var i = 5; i < 10; i++) {
                            visibles[i] = "visible";
                          }
                          for (var i = 15; i < 20; i++) {
                            visibles[i] = "visible";
                          }
                        }
                        rtl = !rtl;
                      });
                    },
                    child: Container(
                        height: getProportionateScreenWidth(40),
                        width: getProportionateScreenWidth(40),
                        child: SvgPicture.asset(
                          rtl ? 'assets/rtb.svg' : 'assets/ltb.svg',
                          fit: BoxFit.contain,
                        )),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.4), borderRadius: BorderRadius.circular(getProportionateScreenWidth(5))),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (teeth == Teeth.Middle) {
                          for (var i = 0; i < visibles.length; i++) {
                            visibles[i] = 'hidden';
                          }
                          for (var i = 3; i < 7; i++) {
                            visibles[i] = 'visible';
                          }
                          for (var i = 13; i < 17; i++) {
                            visibles[i] = 'visible';
                          }
                          teeth = Teeth.Right;
                        } else if (teeth == Teeth.Right) {
                          for (var i = 0; i < visibles.length; i++) {
                            visibles[i] = 'hidden';
                          }
                          for (var i = 7; i < 10; i++) {
                            visibles[i] = 'visible';
                          }
                          for (var i = 17; i < 20; i++) {
                            visibles[i] = 'visible';
                          }
                          teeth = Teeth.Left;
                        } else if (teeth == Teeth.Left) {
                          for (var i = 0; i < visibles.length; i++) {
                            visibles[i] = 'hidden';
                          }

                          for (var i = 0; i < 3; i++) {
                            visibles[i] = 'visible';
                          }
                          for (var i = 10; i < 13; i++) {
                            visibles[i] = 'visible';
                          }
                          teeth = Teeth.Middle;
                        }
                      });
                    },
                    child: Container(
                        height: getProportionateScreenWidth(40),
                        width: getProportionateScreenWidth(40),
                        child: SvgPicture.asset(
                          teeth == Teeth.Middle
                              ? 'assets/midtb.svg'
                              : teeth == Teeth.Right
                                  ? "assets/threeright.svg"
                                  : "assets/threeleft.svg",
                          fit: BoxFit.contain,
                        )),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.4), borderRadius: BorderRadius.circular(getProportionateScreenWidth(5))),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        if (random) {
                          for (var i = 0; i < visibles.length; i++) {
                            visibles[i] = 'hidden';

                            if (i % 2 != 0) {
                              if (visibles[i] == "hidden") {
                                visibles[i] = "visible";
                              } else {
                                visibles[i] = 'hidden';
                              }
                            }
                          }
                          random = !random;
                        } else {
                          for (var i = 0; i < visibles.length; i++) {
                            visibles[i] = 'hidden';

                            if (i % 2 == 0) {
                              if (visibles[i] == "hidden") {
                                visibles[i] = "visible";
                              } else {
                                visibles[i] = 'hidden';
                              }
                            }
                          }
                          random = !random;
                        }
                      });
                    },
                    child: Container(
                        height: getProportionateScreenWidth(40),
                        width: getProportionateScreenWidth(40),
                        child: SvgPicture.asset(
                          random ? 'assets/random2.svg' : "assets/random1.svg",
                          fit: BoxFit.contain,
                        )),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: getProportionateScreenWidth(20),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(10)),
              child: SVGColorGrid(
                onColorSelected: (color) {
                  if (color == "initial.#bdd4de") {
                    setState(() {
                      for (var i = 0; i < visibles.length; i++) {
                        visibles[i] = 'hidden';
                        finalColors[i] = color.split('.')[1].split(':')[0];
                      }
                    });
                  } else
                    for (var i = 0; i < visibles.length; i++) {
                      if (visibles[i] == "visible") {
                        setState(() => finalColors[i] = color.split('.')[1].split(':')[0]);
                      }
                    }
                },
              ),
            )),
          ],
        ),
      ),
    );
  }
}
