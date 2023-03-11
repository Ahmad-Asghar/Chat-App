import 'package:chat_app/Models/MessegeModel.dart';
import 'package:chat_app/Models/chatRoomModel.dart';
import 'package:chat_app/Views/SearchPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../Models/Usermodel.dart';
import '../Widgets/Snackbar.dart';

class ChatRoomPage extends StatefulWidget {

  final UserModel userModel;
  final User firebaseuser;
  final UserModel targetuser;
  final ChatRoomModel chatroom;

  const ChatRoomPage({Key? key,

    required this.userModel,
    required this.firebaseuser,
    required this.chatroom,
    required this.targetuser
  }) : super(key: key);

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {

TextEditingController messegecontroller=TextEditingController();
  Snackbar snack=Get.put(Snackbar());

 void sendMessege() async {
   String msg=messegecontroller.text.toString();
   messegecontroller.clear();
if(msg!=null){
  String id=DateTime.now().microsecondsSinceEpoch.toString();
  MessegeModel newMessege=MessegeModel(

    messegeid: id,
    sender: widget.userModel.uid,
    createdOn: DateTime.now().toString(),
    text: msg,
    seen: false,
  );
  FirebaseFirestore.instance.collection("ChatRooms").
  doc(widget.chatroom.chatRoomId).collection("Messeges").
  doc(newMessege.messegeid).set(newMessege.toMap());

  widget.chatroom.lastmessege=msg;

  FirebaseFirestore.instance.
  collection("ChatRooms").doc(widget.chatroom.chatRoomId).set(widget.chatroom.toMap());
print("Messege sent");
}


 }
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: Row(

            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(widget.targetuser.profilepic.toString()),
              ),
SizedBox(width: 2.w,),
              Text(widget.targetuser.fullName.toString()),
            ],
          ),
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
          child: Column(

            children: [

              Expanded(
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("ChatRooms").doc(widget.chatroom.chatRoomId)
                              .collection("Messeges").snapshots(),
                        builder: (context,snapshot){
                          if(snapshot.connectionState==ConnectionState.active){
                            if(snapshot.hasData){
                              QuerySnapshot datasnapshot=snapshot.data as QuerySnapshot;

                             return ListView.builder(
                               itemCount: datasnapshot.docs.length,
                                 itemBuilder: (context,index){
                                MessegeModel currentmsg= MessegeModel.fromMap(datasnapshot.docs[index].data() as Map<String,dynamic>);

                                return
                                  Padding(
                                    padding:  EdgeInsets.symmetric(vertical: .5.h),
                                    child: Row(
                                      mainAxisAlignment:(currentmsg.sender==widget.userModel.uid)?MainAxisAlignment.end:MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              color: currentmsg.sender==widget.userModel.uid?Colors.grey[500]:Colors.blue,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(11.0),
                                              child: Text(currentmsg.text.toString(),

                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),),
                                            )),
                                      ],
                                    ),
                                  );
                                 });
                            }else if(snapshot.hasError){
                              return Center (
                                child: Container(child: Text("Something went Wrong!\n Check Your Internet Connnection!")),
                              );
                            }
                            else{
                              return Center (
                                child: Text("Say Hi to your friend"),
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
                    ),

              )
              ),



              Container(
                color: Colors.grey[200],
                padding: EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5
                ),
                child: Row(
                  children: [

                    Flexible(
                      child: TextField(
                        controller: messegecontroller,
                        maxLines: null,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter message"
                        ),
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                       // sendMessage();
                        sendMessege();
                      },
                      icon: Icon(Icons.send, color: Theme.of(context).colorScheme.secondary,),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
