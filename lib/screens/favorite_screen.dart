import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisata_jogja/providers/favorite_provider.dart';
import 'package:wisata_jogja/providers/page_provider.dart';
import 'package:wisata_jogja/theme.dart';
import 'package:wisata_jogja/widgets/favorite_card.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FavoriteProvider favoriteProvider =
        Provider.of<FavoriteProvider>(context, listen: false);

    PageProvider pageProvider = Provider.of<PageProvider>(context);
    // DatabaseHelper handler = DatabaseHelper();

    header() {
      return AppBar(
        backgroundColor: orangeColor,
        centerTitle: true,
        title: Text(
          'Wisata Favorite',
          style: whiteTextStyle.copyWith(
            fontSize: 17,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      );
    }

    emptyFavorite() {
      return Expanded(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/icon_lover.png',
                width: 90,
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                'Belum punya tujuan wisata impian?',
                style: blackTextStyle.copyWith(
                  fontWeight: semiBold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Ayo temukan wisata favoritmu',
                style: blackTextStyle.copyWith(
                  fontWeight: light,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 44,
                child: TextButton(
                  onPressed: () {
                    pageProvider.currentIndex = 0;
                  },
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 24,
                      ),
                      backgroundColor: orangeColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      )),
                  child: Text(
                    'Jelajahi Wisata',
                    style: whiteTextStyle.copyWith(),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    content() {
      return Expanded(
        child: Container(
          width: double.infinity,
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            children: favoriteProvider.favorite
                .map((objek) => FavoriteCard(objek: objek))
                .toList(),
          ),
        ),
      );
    }

    // return FutureBuilder(
    //   future: Provider.of<FavoriteProvider>(context, listen: false).getObjek(),
    //   // future: handler.getData(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const Scaffold(
    //         body: Center(
    //           child: CircularProgressIndicator(),
    //         ),
    //       );
    //     } else {
    //       if (snapshot.connectionState == ConnectionState.done) {
    //         return Column(
    //           children: [
    //             header(),
    //             // emptyFavorite(),
    //             favoriteProvider.favorite.isEmpty ? emptyFavorite() : content(),
    //             // content()
    //           ],
    //         );
    //       }
    //     }
    //     return Container();
    //   },
    // );

    return Column(
      children: [
        header(),
        favoriteProvider.favorite.isEmpty ? emptyFavorite() : content(),
      ],
    );
  }
}
