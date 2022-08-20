import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:weight_tracker/app/constants/My%20Widgets/my_text_field.dart';
import 'package:weight_tracker/app/constants/colors.dart';
import 'package:weight_tracker/app/constants/styles.dart';
import 'package:weight_tracker/app/modules/home/Model/weight_model.dart';
import 'package:weight_tracker/app/routes/app_pages.dart';
import 'package:weight_tracker/main.dart';

final homeConProvider = ChangeNotifierProvider((ref) => HomeController());

class HomeController extends ChangeNotifier {
  final _weightKey = GlobalKey<FormState>();
  var weightTextCon = TextEditingController();
  final firestore = FirebaseFirestore.instance;
  WeightModel weightModel = WeightModel();

  void delWeightFirebase({var docId}) {
    cofirmDialog(
      docId: docId,
    );
  }

  void logoutFirebase() {
    cofirmDialog(
      isLogout: true,
    );
  }

  Future<void> addDataFirebase(WeightModel weightModel) async {
    await firestore
        .collection(box.read('userEmail'))
        .add(weightModel.toMap())
        .then((value) {
      // Navigator.of(Get.context!).pop();
    });
  }

  Future<void> updateDataFirebase(WeightModel weightModel, var docId) async {
    await firestore
        .collection(box.read('userEmail'))
        .doc(docId)
        .update(weightModel.toMap());
  }

  Future<void> delFirebaseColection(var docId) async {
    await firestore.collection(box.read('userEmail')).doc(docId).delete();
  }

  Stream<QuerySnapshot> get weightStreams => firestore
      .collection(box.read('userEmail'))
      .orderBy('date', descending: true)
      .snapshots();

  Future<dynamic> cofirmDialog({var docId, bool isLogout = false}) {
    return Get.defaultDialog(
        title: 'Confirmation',
        titlePadding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 8),
        titleStyle: MyStyles.poppinsSemibold(),
        // contentPadding: const EdgeInsets.all(20),
        backgroundColor: MyColors.kGreyClr,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              isLogout == true
                  ? 'Are you sure to logout'
                  : "Are you sure to Delete this Record",
              style: MyStyles.poppinsRegular(),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(Get.context!).pop();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: MyColors.kGreenClr.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10)),
                        height: 40,
                        // width: 60,
                        child: Center(
                          child: Text('No',
                              style: MyStyles.poppinsSemibold(
                                  color: MyColors.kWhiteClr)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 9,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        if (isLogout == false) {
                          await delFirebaseColection(docId);
                          Navigator.of(Get.context!).pop();
                        } else {
                          await FirebaseAuth.instance.signOut();
                          box.remove('userEmail');
                          Get.offAllNamed(Routes.AUTH);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                        height: 40,
                        // width: 60,
                        child: Center(
                          child: Text('Yes',
                              style: MyStyles.poppinsSemibold(
                                  color: MyColors.kWhiteClr)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Future<dynamic> dialog({bool isUpdate = false, var docId, var weight}) {
    if (isUpdate == true) {
      weightTextCon.text = weight;
    }

    return Get.defaultDialog(
        title: isUpdate == false ? 'Add Weight' : 'Update Weight',
        titlePadding: const EdgeInsets.all(20),
        titleStyle: MyStyles.poppinsSemibold(),
        contentPadding: const EdgeInsets.all(20),
        backgroundColor: MyColors.kGreyClr,
        content: Form(
          key: _weightKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MTextField(
                label: 'Add Weight',
                keyboardType: TextInputType.number,
                controller: weightTextCon,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Filed is Required';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: () async {
                  if (_weightKey.currentState!.validate()) {
                    weightModel.userEmail = box.read('userEmail');
                    weightModel.weight = weightTextCon.text;

                    if (isUpdate == false) {
                      weightModel.date =
                          DateTime.now().millisecondsSinceEpoch.toString();
                      await addDataFirebase(weightModel);
                    } else {
                      await updateDataFirebase(weightModel, docId);
                    }

                    // firestore.collection('weight_recods').where('u')
                    Navigator.of(Get.context!).pop();
                    weightTextCon.clear();
                    // addWeightFirebase(weightModel);
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: MyColors.kGreenClr,
                      borderRadius: BorderRadius.circular(10)),
                  height: 50,
                  // width: 60,
                  child: Center(
                    child: Text('Save',
                        style: MyStyles.poppinsSemibold(
                            color: MyColors.kWhiteClr)),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
