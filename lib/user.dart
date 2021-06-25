class User {
  final int? userId;
  final String userLogin;
  final String userEmail;
  final String userPassword;
  final String userCreationDate;

  User({
    this.userId,
    required this.userLogin, 
    required this.userEmail,
    required this.userPassword,
    required this.userCreationDate
  });

  //Recuperer un objet depuis la Map du record set
  User.fromMap(Map<String, dynamic> res)
      : userId = res["userId"],
        userLogin = res["userLogin"],
        userEmail = res["userEmail"],
        userPassword = res["userPassword"],
        userCreationDate = res["userCreationDate"];

  // Transformer objet user en Map pour insertion ou requete ne base
  Map<String, Object?> toMap() {
    return {
      'userId':userId
      ,'userLogin': userLogin
      , 'userEmail': userEmail
      , 'userPassword': userPassword
      , 'userCreationDate': userCreationDate
    };
  }


}