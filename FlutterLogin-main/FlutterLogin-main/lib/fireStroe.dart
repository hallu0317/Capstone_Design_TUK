import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

//컬렉션 필드값 읽기
void readData() {
  final userCollectionReference =
      FirebaseFirestore.instance.collection("member").doc("user");
  userCollectionReference.get().then((value) => {print(value.data())});
}
