// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_presensi/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(20),
        children: [
          /// INFORMASI FOTO PROFIL DAN DATA PEGAWAI
          Row(
            children: [
              /// FOTO PROFIL
              ClipOval(
                child: Container(
                  height: 75,
                  width: 75,
                  color: Colors.grey[200],
                  child: Image.asset(
                    "assets/venturo-k2-194.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "WELCOME",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  SizedBox(height: 5),
                  SizedBox(
                    width: 230,
                    child: Text(
                      "Belum ada lokasi",
                      maxLines: 3,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: 20),

          /// CARD NAMA
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[200],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Programer",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "123456789",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Moh Fauzi Slamet",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),

          /// MASUK KELUAR
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[200],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text("Masuk"),
                    SizedBox(height: 5),
                    GetBuilder<HomeController>(
                      builder: (_) {
                        return Text(
                          controller.user.value.masuk != null
                              ? DateFormat.jms().format(DateTime.now())
                              : "- : - : -",
                        );
                      },
                    ),
                  ],
                ),
                Container(
                  height: 40,
                  width: 2,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                ),
                Column(
                  children: [
                    Text("Keluar"),
                    SizedBox(height: 5),
                    GetBuilder<HomeController>(
                      builder: (_) {
                        return Text(
                          controller.user.value.keluar != null
                              ? DateFormat.jms().format(DateTime.now())
                              : "- : - : -",
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),

          /// GARIS BATAS
          SizedBox(height: 20),
          Divider(
            color: Colors.grey[300],
            thickness: 2,
          ),

          /// INFO LAST ABSENSI
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Last 5 Days",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.toNamed(Routes.allPresensi);
                },
                child: Text(
                  "See more",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),

          /// INFO ABSENSI
          SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Material(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                  child: InkWell(
                    onTap: () {
                      // Get.toNamed(
                      //   Routes.detailPresensi,
                      //   arguments: data,
                      // );
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Masuk",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),

                              /// TANGGAL PRESENCE
                              Text(
                                DateFormat.yMMMEd().format(DateTime.tryParse(
                                        controller.history.masuk?.date ??
                                            DateTime.now().toIso8601String()) ??
                                    DateTime.now()),
                              ),
                            ],
                          ),

                          /// JAM MASUK
                          Text(
                            DateFormat.jms().format(DateTime.now()),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Keluar",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),

                          /// JAM KELUAR
                          Text(
                            DateFormat.jms().format(DateTime.now()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
