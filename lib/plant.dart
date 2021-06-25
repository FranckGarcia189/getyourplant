class Plant {
  final int? plantId;
  final String plantName;
  final String plantOrigin;
  final String plantDescription;
  final String plantPhotoPath;
  final double plantPrice;
  final String plantCreationDate;

  Plant({
    this.plantId,
    required this.plantName, 
    required this.plantOrigin,
    this.plantDescription = "",
    this.plantPhotoPath = "",
    required this.plantPrice,
    required this.plantCreationDate
  });

  //Recuperer un objet depuis la Map du record set
  Plant.fromMap(Map<String, dynamic> res)
      : plantId = res["plantId"],
        plantName = res["plantName"],
        plantOrigin = res["plantOrigin"],
        plantDescription = res["plantDescription"],
        plantPhotoPath = res["plantPhotoPath"],
        plantPrice = res["plantPrice"],
        plantCreationDate = res["plantCreationDate"];

  // Transformer objet user en Map pour insertion ou requete ne base
  Map<String, Object?> toMap() {
    return {
      'plantId':plantId
      ,'plantName': plantName
      , 'plantOrigin': plantOrigin
      , 'plantDescription': plantDescription
      , 'plantPhotoPath': plantPhotoPath
      , 'plantPrice': plantPrice
      , 'plantCreationDate': plantCreationDate
    };
  }
}