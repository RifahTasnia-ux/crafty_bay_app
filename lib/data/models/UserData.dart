class UserData {
  int? id;
  final String? cusName;
  String? cusAdd;
  final String? cusCity;
  String? cusState;
  String? cusPostcode;
  String? cusCountry;
  final String? cusPhone;
  String? cusFax;
  String? shipName;
  final String? shipAdd;
  String? shipCity;
  String? shipState;
  String? shipPostcode;
  String? shipCountry;
  String? shipPhone;
  String? userId;
  String? createdAt;
  String? updatedAt;

  UserData(
      { required this.id,
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
        required this.updatedAt});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cus_name'] = cusName;
    data['cus_add'] = cusAdd;
    data['cus_city'] = cusCity;
    data['cus_state'] = cusState;
    data['cus_postcode'] = cusPostcode;
    data['cus_country'] = cusCountry;
    data['cus_phone'] = cusPhone;
    data['cus_fax'] = cusFax;
    data['ship_name'] = shipName;
    data['ship_add'] = shipAdd;
    data['ship_city'] = shipCity;
    data['ship_state'] = shipState;
    data['ship_postcode'] = shipPostcode;
    data['ship_country'] = shipCountry;
    data['ship_phone'] = shipPhone;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
