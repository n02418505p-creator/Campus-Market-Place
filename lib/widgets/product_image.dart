// lib/widgets/product_image.dart
// Created by: Collins Nyamandu
// Student ID: N02424587C

import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String imagePath;
  final double height;
  final double width;
  final BoxFit fit;

  const ProductImage({
    super.key,
    required this.imagePath,
    this.height = 120,
    this.width = double.infinity,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        child: Image.asset(
          imagePath,
          fit: fit,
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image_not_supported,
                    size: 40,
                    color: Colors.green[300],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'No Image',
                    style: TextStyle(fontSize: 12, color: Colors.green[300]),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
