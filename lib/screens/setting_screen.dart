import 'package:flutter/material.dart';
import 'package:wisata_jogja/theme.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    header() {
      return AppBar(
        backgroundColor: orangeColor,
        centerTitle: true,
        title: Text(
          'Pengaturan',
          style: whiteTextStyle.copyWith(
            fontSize: 17,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      );
    }

    menuItem(String text) {
      return Container(
        margin: const EdgeInsets.only(top: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: greyTextStyle.copyWith(fontSize: 14),
            ),
            const Icon(
              Icons.chevron_right,
              color: greyColor,
            ),
          ],
        ),
      );
    }

    body() {
      return Expanded(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  print('beri nilai');
                },
                child: menuItem('Beri Nilai'),
              ),
              GestureDetector(
                onTap: () {
                  print('tentang');
                },
                child: menuItem('Tentang'),
              ),
              GestureDetector(
                onTap: () {
                  print('about');
                },
                child: menuItem('About'),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        header(),
        body(),
      ],
    );
  }
}
