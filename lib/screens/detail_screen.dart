import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:wisata_jogja/models/objek_model.dart';
import 'package:wisata_jogja/providers/favorite_provider.dart';
import 'package:wisata_jogja/screens/map_screen.dart';
import 'package:wisata_jogja/services/location_service.dart';
import 'package:wisata_jogja/theme.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.objek}) : super(key: key);
  // const DetailScreen(this.objek);
  final ObjekModel objek;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late double latitude = 0;
  late double longitude = 0;
  String? _address;
  String? _city;
  bool isFavorite = false;

  @override
  void initState() {
    getLocation();
    getAddress();
    setState(() {});
    super.initState();
  }

  void getLocation() async {
    MyLocation location = MyLocation();
    await location.getCurrentLocation();

    latitude = await location.getLatitude();
    print(latitude);

    longitude = await location.getLongitude();
    print(longitude);

    setState(() {});
  }

  getAddress() async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(widget.objek.ltd!, widget.objek.lngtd!);
    String address = "${placemarks[1].street}";
    String city = "${placemarks[1].locality}";

    print(placemarks);

    setState(() {
      _address = address;
      _city = city;
    });
  }

  @override
  Widget build(BuildContext context) {
    FavoriteProvider favoriteProvider = Provider.of<FavoriteProvider>(context);

    navigator() {
      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: edge,
          vertical: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                'assets/icons/btn_back.png',
                width: 40,
              ),
            ),
            InkWell(
              onTap: () {
                isFavorite = !isFavorite;

                // getButtonFavoriteMenu(favoriteProvider);

                favoriteProvider.setObjek(widget.objek);
                if (favoriteProvider.isFavorite(widget.objek)) {
                  // if (getButtonFavoriteMenu(favoriteProvider)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: orangeColor,
                      content: Text(
                        'Has been added to the Favorite',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: greyColor,
                      content: Text(
                        'Has been removed from the Favorite',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }

                // setState(() {
                //   getButtonFavoriteMenu(favoriteProvider);
                //   isFavorite = !isFavorite;
                // });
              },
              child: Image.asset(
                // isFavorite
                favoriteProvider.isFavorite(widget.objek)
                    ? 'assets/icons/btn_wishlist_active.png'
                    : 'assets/icons/btn_wishlist.png',
                width: 40,
              ),
            ),
          ],
        ),
      );
    }

    header() {
      return Stack(
        children: [
          Container(
            child: Image.network(
              widget.objek.images![0].images!,
              width: MediaQuery.of(context).size.width,
              height: 350,
              fit: BoxFit.cover,
            ),
          ),
          // navigator(),
        ],
      );
    }

    title() {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: defaultMargin,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.objek.nama!,
              style: blackTextStyle.copyWith(
                fontWeight: semiBold,
                fontSize: 22,
              ),
            ),
            Text(
              widget.objek.category!.nama!,
              style: greyTextStyle.copyWith(
                fontWeight: regular,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    }

    deskripsi() {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: defaultMargin,
          // vertical: 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Deskripsi',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            Text(
              widget.objek.deskripsi!,
              style: greyTextStyle.copyWith(
                fontSize: 13,
                fontWeight: light,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      );
    }

    foto() {
      return Container(
        // margin: const EdgeInsets.symmetric(
        //   vertical: 5,
        // ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: defaultMargin,
              ),
              child: Text(
                'Foto',
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semiBold,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    width: defaultMargin,
                  ),
                  Row(
                    children: widget.objek.images!.map((item) {
                      return Container(
                        margin: EdgeInsets.only(
                          right: 15,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            item.images!,
                            width: 130,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    lokasi() {
      return Container(
        margin: EdgeInsets.symmetric(
          horizontal: defaultMargin,
          // vertical: 5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lokasi',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$_address",
                  style: greyTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: light,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return MapScreen(
                            desLat: widget.objek.ltd!,
                            desLon: widget.objek.lngtd!,
                            souLat: latitude,
                            souLon: longitude,
                            place: widget.objek.nama!,
                          );
                        },
                      ),
                    );
                  },
                  child: Image.asset(
                    'assets/icons/btn_map.png',
                    width: 40,
                  ),
                ),
              ],
            ),
            Text(
              "$_city",
              style: greyTextStyle.copyWith(
                fontSize: 14,
                fontWeight: light,
              ),
            ),
          ],
        ),
      );
    }

    content() {
      return Container(
        child: ListView(
          children: [
            const SizedBox(
              height: 300,
            ),
            Container(
              // width: double.infinity,
              margin: EdgeInsets.only(top: 17),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                color: whiteColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  title(),
                  const SizedBox(
                    height: 10,
                  ),
                  deskripsi(),
                  const SizedBox(
                    height: 10,
                  ),
                  foto(),
                  const SizedBox(
                    height: 10,
                  ),
                  lokasi(),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Stack(
          children: [
            header(),
            content(),
            navigator(),
          ],
        ),
      ),
    );
  }
}
