import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisata_jogja/models/objek_model.dart';
import 'package:wisata_jogja/providers/favorite_provider.dart';
import 'package:wisata_jogja/screens/detail_screen.dart';
import 'package:wisata_jogja/theme.dart';

class FavoriteCard extends StatelessWidget {
  const FavoriteCard({Key? key, required this.objek}) : super(key: key);
  final ObjekModel objek;

  @override
  Widget build(BuildContext context) {
    FavoriteProvider favoriteProvider = Provider.of<FavoriteProvider>(context);

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
        margin: EdgeInsets.only(
          top: 15,
        ),
        padding: EdgeInsets.only(
          top: 10,
          left: 12,
          bottom: 10,
          right: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: tileColor,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                objek.images![0].images!,
                width: 100,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    objek.nama!,
                    style: blackTextStyle.copyWith(
                      fontWeight: semiBold,
                    ),
                  ),
                  Text(
                    objek.category!.nama!,
                    style: greyTextStyle.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                // favoriteProvider.setObjek(objek);
              },
              child: Image.asset(
                'assets/icons/icon_love.png',
                color: orangeColor,
                width: 34,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
