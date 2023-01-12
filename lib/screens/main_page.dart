import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisata_jogja/providers/page_provider.dart';
import 'package:wisata_jogja/screens/favorite_screen.dart';
import 'package:wisata_jogja/screens/home_screen.dart';
import 'package:wisata_jogja/screens/nearby_screen.dart';
import 'package:wisata_jogja/screens/setting_screen.dart';
import 'package:wisata_jogja/theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);

    customBottomNav() {
      return Container(
        height: 68,
        width: MediaQuery.of(context).size.width - (1 * edge),
        margin: EdgeInsets.symmetric(
          horizontal: edge,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(23),
          child: BottomNavigationBar(
            backgroundColor: const Color(0xffF6F7F8),
            type: BottomNavigationBarType.fixed,
            currentIndex: pageProvider.currentIndex,
            // onTap: _onTap,
            onTap: (value) {
              print(value);
              setState(() {
                pageProvider.currentIndex = value;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(
                    top: 15,
                  ),
                  child: Image.asset(
                    'assets/icons/icon_home.png',
                    width: 20,
                    color: pageProvider.currentIndex == 0
                        ? orangeColor
                        : Color(0xff808191),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(
                    top: 15,
                  ),
                  child: Image.asset(
                    'assets/icons/icon_maps.png',
                    width: 20,
                    color: pageProvider.currentIndex == 1
                        ? orangeColor
                        : Color(0xff808191),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(
                    top: 15,
                  ),
                  child: Image.asset(
                    'assets/icons/icon_love.png',
                    width: 20,
                    color: pageProvider.currentIndex == 2
                        ? orangeColor
                        : Color(0xff808191),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  margin: const EdgeInsets.only(
                    top: 15,
                  ),
                  child: Image.asset(
                    'assets/icons/icon_setting.png',
                    width: 20,
                    color: pageProvider.currentIndex == 3
                        ? orangeColor
                        : Color(0xff808191),
                  ),
                ),
                label: '',
              ),
            ],
          ),
        ),
      );
    }

    body() {
      switch (pageProvider.currentIndex) {
        case 0:
          return HomeScreen();
          break;
        case 1:
          return NearbyScreen();
          break;
        case 2:
          return FavoriteScreen();
          break;
        case 3:
          return SettingScreen();
          break;

        default:
          return HomeScreen();
      }
    }

    return Scaffold(
      floatingActionButton: customBottomNav(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: body(),
    );
  }
}
