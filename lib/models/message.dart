class Message {
  late String sentBy;
  late var sentAt;
  late String message;
  late String senderPhotoURL;
  late String? dateTime;

  Message(
      {required this.sentAt,
      required this.sentBy,
      required this.message,
      required this.senderPhotoURL,
      required this.dateTime});
}
