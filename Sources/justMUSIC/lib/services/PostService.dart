import 'dart:io';

import 'package:tuple/tuple.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../main.dart';

class PostService {
  createPost(String? description, String idMusic, File? image,
      Tuple2<String, String>? location) async {
    var id = MyApp.userViewModel.userCurrent.id;
    final post = <String, dynamic>{
      "user_id": id,
      "description": description,
      "date": DateTime.now(),
      "place": [location?.item1, location?.item2],
      "song_id": idMusic,
      "likes": 0
    };

    var postAdd = await MyApp.db.collection("posts").add(post);
    print("cc");
    if (image != null) {
      print("cc3");
      var imageRef = FirebaseStorage.instance.ref('$id${postAdd.id}.jpg');
      await imageRef.putFile(image);
      var imageUrl = await imageRef.getDownloadURL();
      print(imageUrl);
      postAdd.update({"selfie": imageUrl});
    }
    print("cc2");
  }

  deletePost() {}

  getPostsById(String id) {}
}
