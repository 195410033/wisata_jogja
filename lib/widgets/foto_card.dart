import 'package:flutter/material.dart';
import 'package:wisata_jogja/models/objek_model.dart';
import 'package:wisata_jogja/theme.dart';

class FotoCard extends StatelessWidget {
  const FotoCard({Key? key, required this.images}) : super(key: key);
  final ObjekModel images;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      margin: const EdgeInsets.only(
        right: 15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: greyColor,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          images.images![0].images!,
          // 'assets/wisata/tugu.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
