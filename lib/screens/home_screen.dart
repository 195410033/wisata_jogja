import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisata_jogja/models/objek_model.dart';
import 'package:wisata_jogja/providers/objek_provider.dart';
import 'package:wisata_jogja/theme.dart';
import 'package:wisata_jogja/widgets/objek_card.dart';
import 'package:wisata_jogja/widgets/objek_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 4, vsync: this);
    Size size = MediaQuery.of(context).size;
    ObjekProvider objekProvider = Provider.of<ObjekProvider>(context);

    header() {
      return Container(
        margin: EdgeInsets.only(
          top: 35,
          right: defaultMargin,
          left: defaultMargin,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Jelajahi Sekarang",
                  style: blackTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: semiBold,
                  ),
                ),
                Text(
                  "Temukan Destinasi Seru Di\nWilayah Jogja",
                  style: greyTextStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Container(
              height: size.height * 0.12,
              width: size.height * 0.12,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/wisata_jogja.png'),
                ),
              ),
            )
          ],
        ),
      );
    }

    search() {
      return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(
          left: defaultMargin,
          right: defaultMargin,
          top: defaultMargin,
        ),
        // padding: EdgeInsets.only(left: ),
        height: 50,
        decoration: BoxDecoration(
            border: Border.all(
              color: subtitleColor,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(16))),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.search, color: subtitleColor),
              onPressed: () {},
            ),
            Expanded(
              child: TextField(
                // controller: searchController,
                maxLines: 1,
                onChanged: (value) {
                  // handleSearch(value);
                },
                autofocus: false,
                keyboardType: TextInputType.text,
                style: greyTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: medium,
                ),
                textInputAction: TextInputAction.search,
                decoration: InputDecoration.collapsed(
                  hintText: 'Nama Wisata',
                  hintStyle: greyTextStyle.copyWith(
                    fontSize: 15,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.filter_list,
                color: subtitleColor,
              ),
              onPressed: () {},
            ),
          ],
        ),
      );
    }

    destinasiPopulerTitle() {
      return Container(
        margin: EdgeInsets.only(
          left: defaultMargin,
        ),
        child: Text(
          "Destinasi Populer",
          style: blackTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    destinasiPopuler() {
      return Container(
        margin: const EdgeInsets.only(
          top: 10,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                width: defaultMargin,
              ),
              Row(
                children: objekProvider.objek
                    .map((objek) => ObjekCard(objek: objek))
                    .toList(),
              )
            ],
          ),
        ),
      );
    }

    rekomendasiWisataTitle() {
      return Container(
        margin: EdgeInsets.only(
          left: defaultMargin,
          top: 20,
        ),
        child: Text(
          "Rekomendasi Wisata",
          style: blackTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    rekomendasiWisata() {
      return Container(
        margin: EdgeInsets.only(
          left: defaultMargin,
        ),
        child: Column(
          children: [
            Column(
              children: objekProvider.objek
                  .map((objek) => ObjekTile(objek: objek))
                  .toList(),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      );
    }

    pantaiTitle() {
      return Container(
        margin: EdgeInsets.only(
          left: defaultMargin,
          top: 10,
        ),
        child: Text(
          "Wisata Pantai",
          style: blackTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    budayaTitle() {
      return Container(
        margin: EdgeInsets.only(
          left: defaultMargin,
          top: 10,
        ),
        child: Text(
          "Wisata Budaya dan Sejarah",
          style: blackTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    religiTitle() {
      return Container(
        margin: EdgeInsets.only(
          left: defaultMargin,
          top: 10,
        ),
        child: Text(
          "Wisata Religi",
          style: blackTextStyle.copyWith(
            fontSize: 18,
            fontWeight: semiBold,
          ),
        ),
      );
    }

    all() {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            destinasiPopulerTitle(),
            destinasiPopuler(),
            rekomendasiWisataTitle(),
            rekomendasiWisata(),
          ],
        ),
      );
    }

    listPantai() {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            pantaiTitle(),
            rekomendasiWisata(),
          ],
        ),
      );
    }

    listBudaya() {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            budayaTitle(),
            rekomendasiWisata(),
          ],
        ),
      );
    }

    listReligi() {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            religiTitle(),
            rekomendasiWisata(),
          ],
        ),
      );
    }

    customFilter() {
      return Container(
        margin: EdgeInsets.only(
          top: 10,
          bottom: 10,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                width: defaultMargin,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TabBar(
                  indicator: BoxDecoration(
                    color: orangeColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  isScrollable: true,
                  controller: _tabController,
                  labelPadding: EdgeInsets.only(
                    left: defaultMargin,
                    right: defaultMargin,
                  ),
                  labelColor: whiteColor,
                  labelStyle: blackTextStyle,
                  unselectedLabelColor: greyColor,
                  tabs: const [
                    Tab(
                      text: "Semua",
                    ),
                    Tab(
                      text: "Pantai",
                    ),
                    Tab(
                      text: "Budaya dan Sejarah",
                    ),
                    Tab(
                      text: "Religi",
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: defaultMargin,
              ),
            ],
          ),
        ),
      );
    }

    listFilter() {
      return Expanded(
        // height: 500,
        // width: double.maxFinite,
        child: TabBarView(
          controller: _tabController,
          children: [
            all(),
            // ListView.builder(
            //   itemBuilder: (_, index) {
            //     return GestureDetector(onTap: () {}, child: all());
            //   },
            // ),
            listPantai(),
            listBudaya(),
            listReligi(),
          ],
        ),
      );
    }

    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        header(),
        search(),
        customFilter(),
        listFilter(),
      ],
    );
  }
}
