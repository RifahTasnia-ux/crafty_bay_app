class CreateProfile {
  String id;
  String cusName;
  String cusAdd;
  String cusCity;
  String cusState;
  String cusPostcode;
  String cusCountry;
  String cusPhone;
  String cusFax;
  String shipName;
  String shipAdd;
  String shipCity;
  String shipState;
  String shipPostcode;
  String shipCountry;
  String shipPhone;
  String userId;
  DateTime createdAt;
  DateTime updatedAt;

  CreateProfile({
    required this.id,
    required this.cusName,
    required this.cusAdd,
    required this.cusCity,
    required this.cusState,
    required this.cusPostcode,
    required this.cusCountry,
    required this.cusPhone,
    required this.cusFax,
    required this.shipName,
    required this.shipAdd,
    required this.shipCity,
    required this.shipState,
    required this.shipPostcode,
    required this.shipCountry,
    required this.shipPhone,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  /*factory CreateProfile.fromJson(Map<String, dynamic> json) {
    return CreateProfile(
      id: json['id'],
      cusName: json['cus_name'],
      cusAdd: json['cus_add'],
      cusCity: json['cus_city'],
      cusState: json['cus_state'],
      cusPostcode: json['cus_postcode'],
      cusCountry: json['cus_country'],
      cusPhone: json['cus_phone'],
      cusFax: json['cus_fax'],
      shipName: json['ship_name'],
      shipAdd: json['ship_add'],
      shipCity: json['ship_city'],
      shipState: json['ship_state'],
      shipPostcode: json['ship_postcode'],
      shipCountry: json['ship_country'],
      shipPhone: json['ship_phone'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }*/

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cus_name': cusName,
      'cus_add': cusAdd,
      'cus_city': cusCity,
      'cus_state': cusState,
      'cus_postcode': cusPostcode,
      'cus_country': cusCountry,
      'cus_phone': cusPhone,
      'cus_fax': cusFax,
      'ship_name': shipName,
      'ship_add': shipAdd,
      'ship_city': shipCity,
      'ship_state': shipState,
      'ship_postcode': shipPostcode,
      'ship_country': shipCountry,
      'ship_phone': shipPhone,
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
