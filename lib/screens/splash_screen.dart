import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wisata_jogja/providers/objek_provider.dart';
import 'package:wisata_jogja/screens/main_page.dart';
import 'package:wisata_jogja/services/location_service.dart';
import 'package:wisata_jogja/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getGPS();
    getInit();
    super.initState();
  }

  getGPS() async {
    MyLocation location = MyLocation();
    await location.determinePosition();
    setState(() {});
  }

  getInit() async {
    await Provider.of<ObjekProvider>(context, listen: false).getObjek();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset('assets/tugu_jogja.png'),
              // child: Image.asset('assets/tugu_jogja.png',),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                left: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: size.height * 0.15,
                    width: size.height * 0.15,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/wisata_jogja.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text(
                    'Find Destination\nto Stay and Happy',
                    style: blackTextStyle.copyWith(
                      fontSize: 26,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text(
                    'Stop membuang banyak waktu\npada tempat yang tidak sesuai',
                    style: greyTextStyle.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Container(
                    width: size.width * 0.5,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MainPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: orangeColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        'Explore Now',
                        style: whiteTextStyle.copyWith(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
