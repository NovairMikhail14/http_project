import 'package:flutter/material.dart';
import 'package:http_project/Network/http_connection.dart';
import 'package:http_project/PostList.dart';
import 'package:http_project/model/post_model.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String Titlemethod = "Get";
  String title="" ;
  String body="" ;

  final HttpConnection httpConnection  = HttpConnection();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HTTP App"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$Titlemethod",style: TextStyle(fontSize: 30),),
            SizedBox(
              height: 10,
            ),
            Text("Title :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
            SizedBox(
              height: 5,
            ),
            Text("$title :",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
            SizedBox(
              height: 5,
            ),
            Text("Body :",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
            SizedBox(
              height: 15,
            ),
            Text("$body :",style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () async {
                   Post getpost = await httpConnection.fetchPost(1);
                    setState(() {
                       title= getpost.title ;
                       body= getpost.body ;
                       Titlemethod =  "Get"   ;              
                     });
                  },
                  child: Text("Get"),
                ),
                ElevatedButton(
                  onPressed: () async {
                   Post createpost = await httpConnection.createPost("my title","my Post");
                    print(createpost);
                     setState(() {
                      title= createpost.title ;
                       body= createpost.body ;
                       Titlemethod =  "Post"   ;              
                     });
                  },
                  child: Text("Post"),
                ),
                ElevatedButton(
                  onPressed: () async{
                      Post updatepost = await httpConnection.updatePost(1,"my title","my Post");
                      print("--->${updatepost.title}");
                     setState(() {
                      title= updatepost.title ;
                       body= updatepost.body ;
                       Titlemethod =  "Put"   ;              
                     });
                  },
                  child: Text("Put"),
                ),
                ElevatedButton(
                  onPressed: () async{
                      Post deletepost = await httpConnection.deletePost(1);
                    setState(() {
                      title= deletepost.title ;
                      body= deletepost.body ;
                       Titlemethod =  "Delete"   ;              
                     });
                  },
                  child: Text("Delete"),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                  onPressed: () async{
                    Navigator.push(context,MaterialPageRoute(builder: (context) {
                      return MyWidget();
                    },));
                    setState(() {
                       Titlemethod =  "Show All Posts"   ;              
                     });
                  },
                  child: Text("Show All Posts"),
                ),
          ],
        ),
      ),
    );
  }
}
