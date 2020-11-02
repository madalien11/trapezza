class Meal {
  Meal(
      {this.id,
      this.imageUrl,
      this.name,
      this.subtitle,
      this.price,
      this.ingredients,
      this.description,
      this.hasCertificate,
      this.certificateImage});

  int id;
  String imageUrl;
  String name;
  String subtitle;
  int price;
  List<String> ingredients;
  String description;
  bool hasCertificate;
  String certificateImage;
}
