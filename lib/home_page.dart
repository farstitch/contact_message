// ignore_for_file: unused_import

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:contact_message/login_page.dart';
import 'package:contact_message/shared_pref.dart';
import 'package:contact_message/Models/Chart_model.dart';
import 'Models/post.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  var baseUrl = "https://b517-103-17-77-3.ngrok-free.app/api";

  @override
  Widget build(BuildContext context) {
    //ambil data untuk home page
    Future<List<Post>> getData() async {
      var dio = Dio();
      var response = await dio.get(
          "https://instameter-7ffcb-default-rtdb.firebaseio.com/post.json");
      List<Post> listPosts =
          (response.data as List).map((e) => Post.fromJson(e)).toList();
      return listPosts;
    }

    //scr logout
    Future<void> onLogout() async {
      var dio = Dio();
      var token = SharedPref.pref?.getString("token");
      try {
        var response = await dio.post("$baseUrl/logout",
            options: Options(headers: {"Authorization": "Bearer $token"}));
        SharedPref.pref?.remove("token");
        print(response);

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      } catch (e) {
        print("mohon maaf kesalahan email dan  password");
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Message"),
        leading: const Icon(
          Icons.arrow_back_ios, //Icon saja = posisi sebalah kiri
          color: Colors.white,
        ),
        elevation: 0,
      ),
      body: 
      // SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       const SizedBox(
      //         height: 20,
      //         child: Text("Tempat Story"),
      //       ),
      //       // posts
      //       FutureBuilder(
      //           future: getData(),
      //           builder: (context, snapshot) {
      //             if (snapshot.connectionState == ConnectionState.waiting) {
      //               return Center(child: const CircularProgressIndicator());
      //             }

      //             if (snapshot.hasError) {
      //               return Text("ini tampilan ketika error");
      //             } else {
      //               return SizedBox(
      //                 width: MediaQuery.of(context).size.width,
      //                 child: ListView.builder(
      //                   shrinkWrap: true,
      //                   physics: const NeverScrollableScrollPhysics(),
      //                   itemCount: 3, //snapshot.data?.length,
      //                   itemBuilder: (ctx, index) {
      //                     print(index);
      //                     return Container(
      //                         color: Colors.white,
      //                         child: Column(children: [
      //                           Container(
      //                             padding: const EdgeInsets.symmetric(
      //                               horizontal: 10,
      //                               vertical: 10,
      //                             ),
      //                             child: Row(
      //                               mainAxisAlignment:
      //                                   MainAxisAlignment.spaceBetween,
      //                               children: [
      //                                 Row(
      //                                   children: [
      //                                     CircleAvatar(
      //                                       radius: 18, // Image radius
      //                                       backgroundImage: NetworkImage(
      //                                           // "${snapshot.data?[index].picture}"
      //                                           items[index].profileUrl!
      //                                           ),
      //                                     ),
      //                                     const SizedBox(
      //                                       width: 10,
      //                                     ),
      //                                     Text(
      //                                       "${snapshot.data!}",
      //                                       // "${snapshot.data?[index].user}"
      //                                       // items[index].name!,
      //                                     ),
      //                                   ],
      //                                 ),
      //                               ],
      //                             ),
      //                           ),
      //                           Image.network(
      //                             // "${snapshot.data?[index].picture}",
      //                             items[index].profileUrl!,
      //                             width: MediaQuery.of(context).size.width,
      //                           )
      //                         ]));
      //                   },
      //                 ),
      //               );
      //             }
      //           }),
      //     ],
      //   ),
      // ),

//scr contact Message
      ListView.separated(
          itemBuilder: (ctx, i) {
            return ListTile(
              leading: CircleAvatar(
                radius: 28,
                backgroundImage: NetworkImage(items[i].profileUrl!),
              ),
              title: Text(
                items[i].name!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(items[i].message!),
              trailing: Text(items[i].time!),
            );
          },
          separatorBuilder: (ctx, i) {
            return Divider();
          },
          itemCount: items.length),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          onLogout();
        },
        child: Icon(Icons.logout_rounded),
        backgroundColor: Color(0xFF65a9e0),
      ),
    );
  }
}
