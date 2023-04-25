class Products {
  Products({
    required this.Email,
    required this.Category,
    required this.Description,
    required this.Price,
    required this.Title,
    required this.Pic,
    required this.Id,
  });
  late final String Email;
  late final String Category;
  late final String Description;
  late final String Price;
  late final String Title;
  late final String Pic;
  late final String Id;

  Products.fromJson(Map<String, dynamic> json) {
    Email = json['Email'];
    Category = json['Category'];
    Description = json['Description'];
    Price = json['Price'];
    Title = json['Title'];
    Pic = json['Pic'];
    Id = json['Id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['Email'] = Email;
    _data['Category'] = Category;
    _data['Description'] = Description;
    _data['Price'] = Price;
    _data['Title'] = Title;
    _data['Pic'] = Pic;
    _data['Id'] = Id;
    return _data;
  }
}
