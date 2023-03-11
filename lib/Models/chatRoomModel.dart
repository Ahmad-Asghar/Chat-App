class ChatRoomModel{

  String? chatRoomId;
  Map<String,dynamic>? participants;
  String? lastmessege;
  DateTime? datetime;
  List<dynamic>? users;
  ChatRoomModel({this.chatRoomId,this.participants,this.lastmessege,this.datetime,this.users});

  ChatRoomModel.fromMap(Map<String,dynamic>map){
    users=map['users'];
    datetime=map['datetime'].toDate();
    chatRoomId=map['chatRoomId'];
    participants=map['participants'];
    lastmessege=map['lastmessege'];
  }
  Map<String,dynamic> toMap(){
    return {
      'users':users,
      'datetime':datetime,
      'lastmessege':lastmessege,
      'chatRoomId':chatRoomId,
      'participants':participants,

    };
  }
}