import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/application/application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // MemoDbProvider memoDb = MemoDbProvider();
  // final memo = ListTileModel(
  //   id: 1,
  //   title: 'Title 1',
  //   phone: 'Note 1',
  // );

  // await memoDb.addItem(memo);
  // var memos = await memoDb.fetchMemos();
  // print(memos[0].title); //Title 1

  // final newmemo = ListTileModel(
  //   id: memo.id,
  //   title: 'Title 1 changed',
  //   phone: memo.phone,
  // );

  // await memoDb.updateMemo(memo.id!, newmemo);
  // var updatedmemos = await memoDb.fetchMemos();
  // print(updatedmemos[0].title); //Title 1 changed

  // await memoDb.deleteMemo(memo.id!);
  // print(await memoDb.fetchMemos()); //[]

  // memos.forEach((element) {
  //   ListTileWidget(
  //     id: element.id.toString(),
  //     phone: element.phone,
  //     title: element.phone,
  //   );
  // });

  runApp(MyApp());
}
