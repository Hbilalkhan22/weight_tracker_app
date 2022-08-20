// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weight_tracker/app/constants/colors.dart';
import 'package:weight_tracker/app/constants/styles.dart';
import 'package:weight_tracker/app/modules/home/Model/weight_model.dart';

import '../controllers/home_controller.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeProvider = ref.watch(homeConProvider);
    return Scaffold(
        backgroundColor: MyColors.kScaffoldClr,
        appBar: appBar(homeProvider: homeProvider),
        body: weightStream(homeProvider: homeProvider),
        floatingActionButton: FloatingActionButton(
          backgroundColor: MyColors.kBlackClr,
          elevation: 8,
          child: const Icon(
            Icons.add,
            color: MyColors.kWhiteClr,
          ),
          onPressed: () {
            homeProvider.dialog();
          },
        ));
  }

  StreamBuilder<QuerySnapshot<Object?>> weightStream({var homeProvider}) {
    return StreamBuilder<QuerySnapshot>(
        stream: homeProvider.weightStreams,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  var data = WeightModel.fromMap(
                      document.data() as Map<String, dynamic>);

                  return Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: listCard(
                          weight: data.weight,
                          date: data.date,
                          docID: document.id,
                          homeProvider: homeProvider));
                })
                .toList()
                .cast(),
          );
        });
  }

  AppBar appBar({var homeProvider}) {
    return AppBar(
      backgroundColor: MyColors.kGreyClr,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Text(
        'Weights',
        style: MyStyles.poppinsBold(fontSize: 16),
      ),
      centerTitle: false,
      actions: [
        Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {
                homeProvider.logoutFirebase();
              },
              child: Text(
                'Logout',
                style: MyStyles.poppinsBold(fontSize: 14)
                    .copyWith(decoration: TextDecoration.underline),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Padding listCard(
      {String? weight, String? date, var docID, var homeProvider}) {
    final df = DateFormat('dd-MM-yyyy hh:mm a');
    int myvalue = int.parse(date!);
    var formateDate = df.format(DateTime.fromMillisecondsSinceEpoch(myvalue));
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
      ),
      child: Container(
          height: 80,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: MyColors.kGreyClr),
          child: Padding(
            padding: const EdgeInsets.only(top: 15, left: 25, right: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Weight : ',
                          style: MyStyles.poppinsSemibold(fontSize: 12),
                        ),
                        Text(
                          '$weight ',
                          style: MyStyles.poppinsSemibold(fontSize: 13),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      formateDate,
                      style: MyStyles.poppinsMedium(
                          fontSize: 11, color: MyColors.kDarkGreyClr),
                    ),
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        homeProvider.delWeightFirebase(docId: docID);
                      },
                      child: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 29,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () {
                        homeProvider.dialog(
                            isUpdate: true, docId: docID, weight: weight);
                      },
                      child: Icon(
                        Icons.edit,
                        color: Colors.amber[800],
                        size: 29,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
