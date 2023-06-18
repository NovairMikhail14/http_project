import 'package:flutter/material.dart';
import 'package:http_project/Network/http_connection.dart';
import 'package:http_project/model/post_model.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("All Posts List"),
      ),
      body: FutureBuilder(
        future: HttpConnection().getAllPosts(),
        builder:(context,AsyncSnapshot<List<Post>> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
          return Center (
            child: CircularProgressIndicator(),
          );
        } 
        else if(snapshot.hasData) { 
          return ListView.separated(
            padding: EdgeInsets.all(20),
            itemCount: snapshot.data!.length,
            separatorBuilder: (context, index) {
              return Container(
              color: Colors.grey,
              height: 6,
            );
            },
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data![index].title),
                subtitle: Text(snapshot.data![index].body),
              );
            },
          );
        } else{
          return Center(
            child: Text("No Data"),
          );
        };
       }  
      ),
    );
  }
}
