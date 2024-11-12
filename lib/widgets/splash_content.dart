import 'package:flutter/material.dart';
import 'gradient_button.dart';

class SplashContent extends StatelessWidget {
  final String title;
  final String description;
  final List<List<String?>> gridLayout;
  final VoidCallback onNextPressed;

  SplashContent({
    required this.title,
    required this.description,
    required this.gridLayout,
    required this.onNextPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              description,
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 16,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemBuilder: (context, index) {
                    int row = index ~/ 4;
                    int col = index % 4;
                    String? cellValue = gridLayout[row][col];
                    Gradient marbleGradient;

                    if (cellValue == 'P1') {
                      marbleGradient = const LinearGradient(
                        colors: [
                          Color(0xFFFFA07A), // Light Salmon
                          Color(0xFFFA8072), // Salmon
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      );
                    } else if (cellValue == 'P2') {
                      marbleGradient = const LinearGradient(
                        colors: [
                          Color(0xFF87CEFA), // Light Sky Blue
                          Color(0xFF4682B4), // Steel Blue
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      );
                    } else {
                      marbleGradient = const LinearGradient(
                        colors: [Colors.transparent, Colors.transparent],
                      );
                    }

                    return Container(
                      margin: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: marbleGradient,
                        border: Border.all(color: Colors.black, width: 1),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16),
              child: GradientButton(
                text: "Next",
                onPressed: onNextPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
