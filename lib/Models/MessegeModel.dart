

class MessegeModel{
  String? messegeid;
  String? sender;
  bool? seen;
  String? text;
  String? createdOn;

  MessegeModel({this.text,this.createdOn,this.seen,this.sender,this.messegeid});

  MessegeModel.fromMap(Map<String,dynamic>map){
    messegeid=map['messegeid'];
    sender=map['sender'];
    seen=map['seen'];
    text=map['text'];
    createdOn=map['createdOn'];

  }
  Map<String,dynamic> toMap(){
    return {
      'messegeid':messegeid,
      'sender':sender,
      'seen':seen,
      'text':text,
      'createdOn':createdOn,
    };
  }
}