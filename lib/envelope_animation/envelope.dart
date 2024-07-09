import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EnvelopeAnimation extends StatefulWidget {
  const EnvelopeAnimation({super.key});

  @override
  State<EnvelopeAnimation> createState() => _EnvelopeAnimationState();
}

class _EnvelopeAnimationState extends State<EnvelopeAnimation> {
  Color orange = const Color(0xffcc6f32);
  Color green = const Color(0xffc5d3d3);
  double padding = 255;
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: orange,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text('Envelope', style: TextStyle(color:Colors.white, fontWeight:FontWeight.bold),),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              isPressed = true;
            });
          },
          
          child: Center(
              child: Stack(
            children: [
              LetterWidget(isPressed: isPressed),
              Center(child: EnvelopeStack(orange: orange)),
            ],
          )),
        ),
      ),
    );
  }
}

class LetterWidget extends StatelessWidget {
  const LetterWidget({
    super.key,
    required this.isPressed,
  });

  final bool isPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 8000),
      curve: Curves.fastLinearToSlowEaseIn,
      padding: EdgeInsets.only(top: isPressed ? 80 : 260.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        height: 200,
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Dear Viewer',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500)),
                  Text('July 02/2024',
                      style: TextStyle(
                          color: Colors.black, fontSize: 12)),
                ]),
            const SizedBox(height: 50),
            const Text('Nothing Much, I just wanted to say',
                style: TextStyle(color: Colors.black, fontSize: 12)),
            const SizedBox(height: 10),
            if(isPressed)
            const Text(
              'I love you 😍🥰',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w800),
            ). animate().fadeIn(delay: 2000.ms, duration: 3500.ms)
          ],
        ),
      ),
    );
  }
}

class EnvelopeStack extends StatelessWidget {
  const EnvelopeStack({
    super.key,
    required this.orange,
  });

  final Color orange;
  final TextStyle bodyText = const TextStyle(
    color: Colors.white,
    fontSize: 12,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              color: orange,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                    child: Text(
                  'Tap to see my message',
                  style: bodyText,
                )))),
        Positioned(
          top: 0,
          child: Padding(
            padding: const EdgeInsets.only(top:0.0),
            child: ClipPath(
              clipper: FlapClipper(),
              child: Container(
                width: 387,
                height: 70,decoration: BoxDecoration(color:Colors.white , border: Border.all(width:0, color:Colors.white)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class FlapClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width * 0.9, size.height);
    path.lineTo(size.width * 0.1, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
