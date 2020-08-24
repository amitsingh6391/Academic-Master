import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:link_text/link_text.dart';
import 'package:Academicmaster/pages/socialmedia.dart';
import 'package:Academicmaster/pages/uploaduserprofile.dart';


import 'package:Academicmaster/view/SignIn.dart';
import 'package:Academicmaster/view/helper/authnicate.dart';
import 'package:Academicmaster/view/viewservices/auth.dart';
import "package:cloud_firestore/cloud_firestore.dart";


import "package:Academicmaster/services/crud.dart";

class Alluserprofile extends StatefulWidget {
   String userid;
  Alluserprofile({@required this.userid});
  @override
  _AlluserprofileState createState() => _AlluserprofileState();
}

class _AlluserprofileState extends State<Alluserprofile> {
 // String userid;
   //String instagram,linkdin,github;

  @override
  void initState() {
    // TODO: implement initState
   // getCurrentUser();
   print(widget.userid);
    super.initState();
  }

  getCurrentUser() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser user = await _auth.currentUser();
    final uid = user.uid;
    print(uid);
    setState(() {
     // userid = uid.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.black,
        onPressed: (){
        Navigator.pop(context);
      },
      child:Icon(Icons.arrow_back,color:Colors.white)),
      backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
      children: <Widget>[
        

        Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: <Widget>[
              StreamBuilder(
                  stream: Firestore.instance
                      .collection("userprofile")
                      .document(widget.userid)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text("Loading");
                    }

                    var Profiledetail = snapshot.data;
                   var instagram = Profiledetail["insta"];
                    var linkdin = Profiledetail["linkdin"];
                    var github = Profiledetail["github"];
                      print(github);
                    return Column(
                      children: <Widget>[
                        Row(children: [
                          ClipOval(
                              child: CachedNetworkImage(
                                  imageUrl: Profiledetail["profileimageurl"],
                                  height: 150,
                                  width: 150,
                                  fit: BoxFit.cover)),
                          SizedBox(width: 5),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color:Colors.black,
                                child: Column(children: [
                              Text("Followers",
                                  style: TextStyle(
 color:Colors.white,
                                      fontSize: 20,
                                      fontFamily: "Dancing",
                                      fontWeight: FontWeight.bold)),
                              Text(Profiledetail["follower"].toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      color:Colors.green,
                                      fontWeight: FontWeight.bold))
                            ])),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              color:Colors.black,
                                child: Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text("Following".toString(),
                                    style: TextStyle(
                                      color:Colors.white,
                                        fontSize: 18,
                                        fontFamily: "Dancing",
                                        fontWeight: FontWeight.bold)),
                              ),
                              Text(Profiledetail["following"].toString(),
                                  style: TextStyle(
                                     color:Colors.red,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))
                            ])),
                          )
                        ]),
                        Row(children: [
                          Text(Profiledetail["userName"],
                              style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: "Dancing",
                                  fontWeight: FontWeight.bold)),
                        GestureDetector(

                          onTap: (){
                            Navigator.push(context,MaterialPageRoute(builder:(context)=>Socialmedia(link:github)));
                          },

                          child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  AssetImage("images/github.png"),
                            ),
                          ),),

                          GestureDetector(

                             onTap: (){
                            Navigator.push(context,MaterialPageRoute(builder:(context)=>Socialmedia(link:instagram)));
                          },
                            
                            child:Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  AssetImage("images/instaicon.jpg"),
                            ),
                          ),),
                         GestureDetector(

                            onTap: (){
                            Navigator.push(context,MaterialPageRoute(builder:(context)=>Socialmedia(link:linkdin)));
                          },
                           
                           child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  AssetImage("images/linkdinicon.jpg"),
                            ),
                          ))
                        ]),
                        Row(
                          children: <Widget>[
                            Text("Bio :",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Dancing",
                                    fontWeight: FontWeight.bold)),

                                    SizedBox(width:80),
                            

                            SizedBox(
                              width:50
                            ),
         
                          ],
                        ),
                        Container(
                          width:MediaQuery.of(context).size.width,
                          child: Text(Profiledetail["bio"],
                              style: TextStyle(
                                  fontSize: 17,fontFamily: "Dancing" )),
                        ),
                        SizedBox(height:5),
                        Container(
                          width:MediaQuery.of(context).size.width,
                          child: Column(
                            children: <Widget>[

                              Row(
                                children: <Widget>[
                                  Text("College:",style: TextStyle(
                                fontSize: 17,fontFamily: "Dancing",fontWeight: FontWeight.bold )),

                                SizedBox(width:10),Text(Profiledetail["usercollege"],style: TextStyle(
                                fontSize: 17,fontFamily: "Dancing" )),

                                ],
                              ),
                              SizedBox(height:10),
                               Row(
                                children: <Widget>[
                                  Text("Your-email:",style: TextStyle(
                                fontSize: 17,fontFamily: "Dancing",fontWeight: FontWeight.bold )),

                                SizedBox(width:10),Text(Profiledetail["userEmail"],style: TextStyle(
                                fontSize: 17,fontFamily: "Dancing" )),

                                ],
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: <Widget>[
                                  Text("Stream :",style: TextStyle(
                                fontSize: 17,fontFamily: "Dancing",fontWeight: FontWeight.bold )),

                                SizedBox(width:10),Text(Profiledetail["userbranch"],style: TextStyle(
                                fontSize: 17,fontFamily: "Dancing" )),

                                SizedBox(width: 20,),
                                Text("Year :",style: TextStyle(
                                fontSize: 17,fontFamily: "Dancing",fontWeight: FontWeight.bold )),

                                SizedBox(width: 10,),
                                Text(Profiledetail["useryear"],style: TextStyle(
                                fontSize: 17,fontWeight: FontWeight.bold )),

                                ],
                              )

                            ],
                          )
                        ),
                      ],
                    );
                  }),
                    Text("Your Posts: ",
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Dancing")),
                StreamBuilder(
                  stream: Firestore.instance.collection(widget.userid).snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      print("Loading");
                    }
                   return  ListView.builder(
                        reverse: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        itemCount: snapshot.data.documents.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Column(
                            children: <Widget>[
                              BlogsTile(
                                title: snapshot
                                    .data.documents[index].data["title"],
                                
                                imgUrl: snapshot
                                    .data.documents[index].data['imgUrl'],
                                posttime: snapshot
                                    .data.documents[index].data["posttime"],
                                postLike:
                                    snapshot.data.documents[index].data["like"],
                                disLike: snapshot
                                    .data.documents[index].data["dislike"],
                              ),
                            ],
                          );
                        });
                  },
                )
            ],
          ),
        )
      ],
    )))
    );
  }
}


class BlogsTile extends StatefulWidget {
  String title,imgUrl,posttime,postLike,disLike;
  BlogsTile({@required this.title,@required this.imgUrl,@required this.posttime,@required this.postLike,@required this.disLike});
  @override
  _BlogsTileState createState() => _BlogsTileState();
}

class _BlogsTileState extends State<BlogsTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Card(
        child: Column(
          children:[
            Image(image: NetworkImage(widget.imgUrl),),
            SizedBox(
              height:10
            ),
            Text(widget.title, style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Dancing")),

                       

                        Row(
                          children: <Widget>[
                            Text("PostDate:",),
                             Text(widget.posttime, style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                       )),
                          ],
                        ),
                         Row(
                          children: <Widget>[
                            Text("Likes:",),
                             Text(widget.postLike, style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                       )),

                       SizedBox(width:50,),
                       Text("DisLikes:",),
                       Text(widget.disLike, style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                       ))
                          ],
                        )


          ]
        ),
      )
    );
  }
}
