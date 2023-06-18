import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_project/model/post_model.dart';

class HttpConnection {
  String BaseUrl = "https://jsonplaceholder.typicode.com/";
  String EndPoint = "posts";
  final client = http.Client();

  Future<Post> fetchPost(int id) async {
    Response response =
        await client.get(Uri.parse(BaseUrl + EndPoint + "/$id"));
    if (response.statusCode == 200) {
      String body = response.body;
      Map<String, dynamic> map = jsonDecode(body);
      Post _post = Post.fromJson(map);
      return _post;
    } else
      throw Exception("Failed to load post $id");
  }

  Future<Post> createPost(String title, String body) async {
    Map mymap = {"title": title, "body": body};
    Response response = await client.post(
      Uri.parse(BaseUrl + EndPoint),
      body: jsonEncode(mymap),
    );
    if (response.statusCode == 201) {
      String body = response.body;
      Map<String, dynamic> map = jsonDecode(body);
      Post _post = Post.fromJson(map);
      return _post;
    } else
      throw Exception("Failed to create post ${response.statusCode}");
  }

  Future<Post> updatePost(int id, String title, String body) async {
    Map mymap = {"title": title, "body": body};
    Response response = await client.put(Uri.parse(BaseUrl + EndPoint + "/$id"),
        body: jsonEncode(mymap),
        headers: {'Content-Type': 'application/json; charset=UTF-8'});
    if (response.statusCode == 200) {
      String body = response.body;
      Map<String, dynamic> map = jsonDecode(body);
      Post _post = Post.fromJson(map);
      return _post;
    } else
      throw Exception("Failed to load post $id ---->${response.statusCode}");
  }

  Future<Post> deletePost(int id) async {
    Response response = await client.delete(
      Uri.parse(BaseUrl + EndPoint + "/$id"),
    );
    if (response.statusCode == 200) {
      String body = response.body;
      Map<String, dynamic> map = jsonDecode(body);
      Post _post = Post.fromJson({});
      return _post;
    } else
      throw Exception("Failed to load post $id");
  }

  Future<List<Post>> getAllPosts() async {
    Response response = await client.get(
      Uri.parse(BaseUrl + EndPoint),
    );
    if (response.statusCode == 200) {
      String body = response.body;
      List<dynamic> bodylist = jsonDecode(body);
      List<Post> allposts = bodylist
          .map(
            (e) => Post.fromJson(e),
          )
          .toList();
      return allposts;
    } else
      return [];
  }
}
