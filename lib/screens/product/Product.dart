class Product {
  final String id;
  final String name;
  final String description;
  final int price;
  final int quanty;

  Product(this.id, this.name, this.description, this.price, this.quanty) {
    if (id == null) {
      throw new ArgumentError("id of Product cannot be null. "
          "Received: '$id'");
    }
    if (name == null) {
      throw new ArgumentError("name of Product cannot be null. "
          "Received: '$name'");
    }
    if (description == null) {
      throw new ArgumentError("description of Product cannot be null. "
          "Received: '$description'");
    }
    if (price == 0) {
      throw new ArgumentError("price of Product cannot be null. "
          "Received: '$price'");
    }
    if (quanty == 0) {
      throw new ArgumentError("quanty of Product cannot be null. "
          "Received: '$quanty'");
    }
  }
}