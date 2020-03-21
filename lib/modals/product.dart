class Product {
  int _id;
  String _name;
  String _dsc;
  double _price;

  Product(this._name, this._dsc, this._price);

  // named constructor //
  Product.withId(this._id, this._name, this._dsc, this._price);

  int get id => _id;
  String get name => _name;
  double get price => _price;
  String get dsc => _dsc;

  set id(int value) {
    _id = value;
  }

  set name(String value) {
    if (value.length > 2) {
      _name = value;
    }
  }

  set dsc(String value) {
    if (value.length > 10) {
      _dsc = value;
    }
  }

  set price(double value) {
    if (value > 0) {
      _price = value;
    }
  }

  Map<String, dynamic> toMap() {
    Map map = Map<String, dynamic>();

    map["name"] = name;
    map["dsc"] = dsc;
    map[price] = price;

    if (id != null && id > 0) {
      map["id"] = id;
    }

    return map;
  }

  Product.fromObject(dynamic o){
    id = o["id"];
    name = o["name"];
    dsc = o["dsc"];
    price = o["price"];
  }
}
