import 'package:chat_app/Models/chatRoomModel.dart';
import 'package:chat_app/Views/ChatRoomPage.dart';
import 'package:chat_app/Views/SearchPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Models/FirebaseHelper.dart';
import '../Models/Usermodel.dart';
import '../Widgets/Snackbar.dart';
import 'SignUpPage.dart';

class HomePage extends StatefulWidget {

  final UserModel userModel;
  final User firebaseuser;
  const HomePage({Key? key,required this.userModel,required this.firebaseuser}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  Snackbar snack=Get.put(Snackbar());
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPage(userModel: widget.userModel, firebaseuser: widget.firebaseuser)));
          },
          child: Icon(Icons.search),
        ),
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: (){

                FirebaseAuth.instance.signOut().then((value) => {

                  Get.off(SignUpPage()),
                });

              },
              icon: Icon(Icons.login),
            ),
          ],
          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text("Let's Chat"),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/chat.png",),

                  opacity: 0.3,
                  fit: BoxFit.contain
              )
          ),
          child: Container(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.
              collection("ChatRooms").where("users",arrayContains: widget.userModel.uid).orderBy("datetime").snapshots(),
              builder: (context,snapshot){
                if(snapshot.connectionState==ConnectionState.active){

                  if(snapshot.hasData){
QuerySnapshot chatroomsnapshot=snapshot.data as QuerySnapshot;
                  return ListView.builder(
     itemCount: chatroomsnapshot.docs.length,
               itemBuilder: (context,index){

         ChatRoomModel chatrummodel=ChatRoomModel.fromMap(
             chatroomsnapshot.docs[index].data() as Map<String,dynamic>);

         Map<String,dynamic> participants=chatrummodel.participants!;

         List<String> participantskeys=participants.keys.toList();
         participantskeys.remove(widget.userModel.uid);
         return FutureBuilder(
             future:FirebaseHelper.getUserMOdelById(participantskeys[0]),
             builder: (context,userData){
             if(userData.connectionState==ConnectionState.done){
              if(userData.data!=null){
                UserModel targetuser=userData.data as UserModel;
                return ListTile(
                  onTap: (){
                    Get.to(ChatRoomPage(userModel:
                    widget.userModel,
                        firebaseuser: widget.firebaseuser,
                        chatroom: chatrummodel,
                        targetuser: targetuser));
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(
                        targetuser.profilepic.toString()
                    ),
                  ),
                  title: Text(targetuser.fullName.toString()),
                  subtitle: Text(chatrummodel.lastmessege.toString()),
                );
              }
else{
  return Container();

              }
             }
             else{
               return Container();
             }
         });
               });
                  }
                  else if(snapshot.hasError){
                    return Center(
                      child: Text("Something went Wrong!",style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),),
                    );
                  }
                  else{
                    return Center(
                      child: Text("No Chats!"),
                    );
                  }
                }

                else{
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )
        ),
      ),
    );
  }
}
