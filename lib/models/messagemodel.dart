class Message implements Comparable<Message>{
String? message="";
DateTime creationDt;
String? type;
int ? from;
int ?to;
String ? translateMessage;
String documentId;

Message({
  required this.translateMessage,
  required this.documentId,
   required this.type,
    required this.message,
    required this.creationDt,
     required this.from,
    required this.to
  });

 @override
int compareTo(Message other) {
  // TODO: implement compareTo
  if(this.creationDt.isBefore(other.creationDt)  ){
    return 1;
  }else{
    return -1;
  }
}
}