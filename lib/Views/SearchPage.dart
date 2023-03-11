import 'dart:async';

import 'package:chat_app/Views/ChatRoomPage.dart';
import 'package:chat_app/Views/SignUpPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../Models/Usermodel.dart';
import '../Models/chatRoomModel.dart';
import '../Widgets/Snackbar.dart';
import '../Widgets/TextField.dart';

class SearchPage extends StatefulWidget {

  final UserModel userModel;
  final User firebaseuser;
  const SearchPage({Key? key,required this.userModel,required this.firebaseuser}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {


  Snackbar snack=Get.put(Snackbar());
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
  }
  TextEditingController emailsearchcontroller=TextEditingController();

  Future<ChatRoomModel?> getChatRoomModel( UserModel targetUser) async {
    ChatRoomModel? chatroom;
   QuerySnapshot snapshot= await FirebaseFirestore.instance.collection("ChatRooms")
       .where("participants.${widget.userModel.uid}",isEqualTo:true)
       .where("participants.${targetUser.uid}",isEqualTo:true).get();

   if(snapshot.docs.isNotEmpty){
     print("Already Have a Chat Room");

     var docData=snapshot.docs[0].data();
     ChatRoomModel existingChatRoom=ChatRoomModel.fromMap(docData as Map<String,dynamic>);
     chatroom=existingChatRoom;
   }
   else{
     print("Create a Chat Room");
     String id=DateTime.now().microsecondsSinceEpoch.toString();
     ChatRoomModel newChatRoom=ChatRoomModel(

       chatRoomId:id,
       lastmessege: "",
       participants: {

         widget.userModel.uid.toString():true,
         targetUser.uid.toString():true,
       },
       users: [widget.userModel.uid.toString(),targetUser.uid.toString()],
       datetime: DateTime.now(),
     );
     await FirebaseFirestore.instance.collection("ChatRooms").doc(newChatRoom.chatRoomId).set(newChatRoom.toMap());
chatroom=newChatRoom;
     print("Chat Room Created!");
   }
   return chatroom;
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(

          backgroundColor: Colors.blue,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text("Search Page"),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/chat.png"),
                  opacity: 0.3,
                  fit: BoxFit.contain
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 3.h,),
              Textfield(email: emailsearchcontroller, icon: Icons.alternate_email, hintext: "Email", mesege: 'Enter Email',),
SizedBox(height: 1.h,),
              MaterialButton(
                minWidth: 40.w,
                onPressed: (){
                  setState(() {

                  });
                },
              child: Text("Search",
              style: TextStyle(
                color: Colors.white
              ),
              ),
                color: Colors.blue,
              ),
             StreamBuilder<QuerySnapshot>(
               stream: FirebaseFirestore.instance.collection("Users").where
                 ("email",isEqualTo: emailsearchcontroller.text).where("email", isNotEqualTo: widget.userModel.email).snapshots(),
               builder: (context,snapshot){
//print(emailsearchcontroller.text);
                 if(snapshot.connectionState==ConnectionState.active){

                   if(snapshot.hasData){
               QuerySnapshot<Object?>? datasnapshot=snapshot.data;

                if(datasnapshot!.docs.isNotEmpty){

               Map<String,dynamic> userMap=datasnapshot?.docs[0].data() as Map<String,dynamic>;
print(userMap.length.toString());


              UserModel searchedUser=UserModel.fromMap(userMap);
print(searchedUser.fullName.toString());
            //  print(searchedUser.fullName.toString());
             // searchedUser.toString();
                return ListTile(
                  onTap: () async {
ChatRoomModel? chatroomModel= await getChatRoomModel(searchedUser);
if(chatroomModel!=null){
  Navigator.pop(context);
  Get.to(ChatRoomPage(
    userModel: widget.userModel,
      firebaseuser: widget.firebaseuser,
      targetuser: searchedUser,
    chatroom: chatroomModel,

  ));

}

                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(searchedUser.profilepic.toString()),
                  ),
             title: Text(searchedUser.fullName.toString()),
           subtitle: Text(searchedUser.email.toString()),
                  trailing: Icon(Icons.keyboard_arrow_right),
  );
}
else{
  return Text("No Results Found");
}

                   }
                   else if(snapshot.hasError){
                     return Text("Error!");
                   }
                   else{
                     return Text("No Results Found");
                   }
                 }
                 else{
                   return CircularProgressIndicator();
                 }
               }
             )
            ],
          ),
        ),
      ),
    );
  }
}
