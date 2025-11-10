class Swap {
  String id;
  String bookId;
  String senderId;
  String recipientId;
  String status; // Pending, Accepted, Rejected

  Swap({
    required this.id,
    required this.bookId,
    required this.senderId,
    required this.recipientId,
    required this.status,
  });

  factory Swap.fromMap(Map<String, dynamic> data, String docId) => Swap(
    id: docId,
    bookId: data['bookId'],
    senderId: data['senderId'],
    recipientId: data['recipientId'],
    status: data['status'],
  );

  Map<String, dynamic> toMap() => {
    'bookId': bookId,
    'senderId': senderId,
    'recipientId': recipientId,
    'status': status,
  };
}
