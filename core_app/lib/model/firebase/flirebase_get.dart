import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseMethods {
/*  to init Firebase and to call Users docs method */
  var initAndGetData = FirebaseFirestore.instance.collection("users");
  var initTags = FirebaseFirestore.instance.collection("tags");

  static var initAndGetDataTag =
      FirebaseFirestore.instance.collection("tagsCollection");

/*  to updateData  method */
  updateData<ModelGate>({
    required String addTag,
    required String idDocNumber,
  }) async {
    var updateData = await initAndGetData.doc(idDocNumber);
    var doneGet = await updateData.get();

    if (doneGet.get("tag1".isEmpty)) {
      updateData.update({"tag1": addTag});
    } else if (doneGet.get("tag2") == "") {
      updateData.update({"tag2": addTag});
    } else if (doneGet.get("tag3") == "") {
      updateData.update({"tag3": addTag});
    }

    return updateData;
  }

  /*   To add tags  */
  addTagData<ModelGate>({
    required String addTag,
    required String idDocNumber,
    required String name,
    // required List listOfTags,
  }) async {
    CollectionReference tagsCollection =
        FirebaseFirestore.instance.collection('tagsCollection');

    await tagsCollection.doc(idDocNumber).set({
      'name': name,
      'idDocNumber': idDocNumber,
      'listOfTags': addTag,
    });
  }

/*  to delete a tag with index tag method */
  deleteTag<ModelGate>(
      {required String idDocNumber, required int indexTag}) async {
    var setData = await initAndGetData
        .doc(idDocNumber)
        .update({"$indexTag tag": FieldValue.delete()});
    return setData;
  }
//

  addData<ModelGate>(
      {required String tag,
      required String doc,
      required String numberOfTag}) async {
    CollectionReference tagsCollection =
        FirebaseFirestore.instance.collection('users');

    await tagsCollection.doc(doc).update({"tag$numberOfTag": tag});
  }

  addGetTag<ModelGate>({required String doc}) async {
    var setData = await initAndGetData.doc(doc).get();
    return setData.get("tagConnt");
  }

  //////////////////////////

  searchUsersByAge(String tag) {
    return initAndGetData.where('tag', isEqualTo: tag);
  }

  Future<void> addUser(
      {required String name,
      required String address,
      required String phoneNumber,
      required String almajlis,
      required String idNumber,
      required String bookingNumber,
      required String nationality,
      required String typeOfSex,
      required String monaCamp,
      required String almajlisMona,
      required String mnamMona,
      required String arafaCamp,
      required String almajlisarafa,
      required String mnamarafaa,
      required String tag1,
      required String tag2,
      required String tag3}) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.doc(idNumber).set({
      'name': name, // الاسم
      'address': address, // العنوان
      'phoneNumber': phoneNumber, // رقم الجوال
      'almajlis': almajlis, // المجلس
      'idNumber': idNumber, // رقم الهوية
      'bookingNumber': bookingNumber, // رقم الحجز
      'nationality': nationality, // الجنسية
      'typeOfSex': typeOfSex, // الجنس
      'monaCamp': monaCamp, // مخيم منى
      'almajlisMona': almajlisMona, // مجلس منى
      'mnamMona': mnamMona, // منام منى
      'arafaCamp': arafaCamp, // مخيم عرفة
      'almajlisarafa': almajlisarafa, // مجلس عرفة
      'mnamarafaa': mnamarafaa, // منام عرفة
      'tag1': tag1,
      'tag2': tag2,
      'tag3': tag3,
    });
  }

////////////////////////////////////////////
  Future<void> addUserTag({required String docTag}) async {
    CollectionReference tag = FirebaseFirestore.instance.collection('tags');
    await tag.doc(docTag).set({'tag': docTag});
  }

  Future getTges() async {
    var tag = await initTags.get();
    return tag;
  }
}
