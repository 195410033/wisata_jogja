import 'package:flutter/material.dart';
import 'package:wisata_jogja/models/objek_model.dart';
import 'package:wisata_jogja/screens/detail_screen.dart';
import 'package:wisata_jogja/theme.dart';

class ObjekTile extends StatelessWidget {
  const ObjekTile({Key? key, required this.objek}) : super(key: key);
  // ObjekTile(this.objek);
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
        height: 130,
        width: double.infinity,
        margin: EdgeInsets.only(
          top: 10,
          right: defaultMargin,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: tileColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                width: 110,
                height: 110,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      objek.images![0].images!,
                      // 'assets/wisata/tugu.png',
                      fit: BoxFit.cover,
                    )),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      objek.nama!,
                      // "Tugu Jogja",
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                      // softWrap: false,
                      maxLines: 2,
                    ),
                    Text(
                      objek.category!.nama!,
                      // "Budaya dan Sejarah",
                      style: greyTextStyle.copyWith(
                        fontSize: 13,
                        fontWeight: light,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
