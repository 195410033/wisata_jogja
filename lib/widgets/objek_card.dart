import 'package:flutter/material.dart';
import 'package:wisata_jogja/models/objek_model.dart';
import 'package:wisata_jogja/screens/detail_screen.dart';
import 'package:wisata_jogja/theme.dart';

class ObjekCard extends StatelessWidget {
  const ObjekCard({Key? key, required this.objek}) : super(key: key);
  // ObjekCard(this.objek);
  final ObjekModel objek;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(objek: objek),
          ),
        );
      },
      child: Container(
        width: 285,
        height: 160,
        margin: const EdgeInsets.only(
          right: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: greyColor,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(children: [
            Image.network(
              objek.images![0].images!,
              width: 285,
              height: 160,
              // 'assets/wisata/tugu.png',
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    objek.nama!,
                    // "Tugu Yogyakarta",
                    style: whiteTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: semiBold,
                    ),
                  ),
                  Text(
                    objek.category!.nama!,
                    // "Budaya dan Sejarah",
                    style: whiteTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: light,
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
