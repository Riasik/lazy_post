class ParcelHistory{
  double weight;
  double length;
  double width;
  double height;
  double volume;
  double price;
  double senderLat;
  double senderLng;
  double senderDistance;
  double receiverLat;
  double receiverLng;
  double receiverDistance;
  List<int>? logistic;
  DateTime createdAt;
  List<int>? resultLogisticIds;

  ParcelHistory(
      this.weight,
      this.length,
      this.width,
      this.height,
      this.volume,
      this.price,
      this.senderLat,
      this.senderLng,
      this.senderDistance,
      this.receiverLat,
      this.receiverLng,
      this.receiverDistance,
      this.createdAt,
      {List<int>? logistic,
      List<int>? resultLogisticIds});
}