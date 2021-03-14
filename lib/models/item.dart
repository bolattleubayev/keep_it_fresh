class Item {
  final String uid;
  final String id;
  final String title;
  final String description;
  final String imageURL;

  final int barcode;
  final DateTime expiryDate;
  final String skinType;
  final String ageRange;
  final String location;
  final List<String> secondaryImageURLs;

  Item({
    this.uid,
    this.id,
    this.title,
    this.description,
    this.imageURL,
    this.barcode,
    this.expiryDate,
    this.skinType,
    this.ageRange,
    this.location,
    this.secondaryImageURLs,
  });

  static final List<Item> dummyData = [
    Item(
      uid: "Assem Assanova",
      id: "001",
      title: "Cream ABC",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      imageURL:
          "https://assets.epicurious.com/photos/57631b4eff66dde1456dfed4/master/pass/sweetened-whipped-cream.jpg",
      barcode: 80941828,
      expiryDate: DateTime(2020, 12, 12),
      skinType: "dry",
      ageRange: "20-25",
      location: "Nur-Sultan, Kazakhstan",
      secondaryImageURLs: [
        "https://www.noracooks.com/wp-content/uploads/2019/10/IMG_8457.jpg",
        "https://www.cookingclassy.com/wp-content/uploads/2019/04/whipped-cream-1.jpg",
        "https://betterthanbreadketo.com/wp-content/uploads/2020/01/Keto-Whipped-Cream_4-720x540.jpg",
      ],
    ),
    Item(
      uid: "Altyn Manassova",
      id: "002",
      title: "Cream BCD",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      imageURL:
          "https://www.noracooks.com/wp-content/uploads/2019/10/IMG_8457.jpg",
      barcode: 80941118,
      expiryDate: DateTime(2020, 11, 11),
      skinType: "not dry",
      ageRange: "25-30",
      location: "Almaty, Kazakhstan",
      secondaryImageURLs: [
        "https://www.cookingclassy.com/wp-content/uploads/2019/04/whipped-cream-1.jpg",
        "https://betterthanbreadketo.com/wp-content/uploads/2020/01/Keto-Whipped-Cream_4-720x540.jpg",
        "https://assets.epicurious.com/photos/57631b4eff66dde1456dfed4/master/pass/sweetened-whipped-cream.jpg",
      ],
    ),
    Item(
      uid: "Merey Kassymova",
      id: "003",
      title: "Cream CDE",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      imageURL:
          "https://www.cookingclassy.com/wp-content/uploads/2019/04/whipped-cream-1.jpg",
      barcode: 81111828,
      expiryDate: DateTime(2020, 10, 10),
      skinType: "super dry",
      ageRange: "30-35",
      location: "Kongo",
      secondaryImageURLs: [
        "https://www.noracooks.com/wp-content/uploads/2019/10/IMG_8457.jpg",
        "https://assets.epicurious.com/photos/57631b4eff66dde1456dfed4/master/pass/sweetened-whipped-cream.jpg",
        "https://betterthanbreadketo.com/wp-content/uploads/2020/01/Keto-Whipped-Cream_4-720x540.jpg",
      ],
    ),
    Item(
      uid: "Madina Assanova",
      id: "004",
      title: "Cream DEF",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      imageURL:
          "https://betterthanbreadketo.com/wp-content/uploads/2020/01/Keto-Whipped-Cream_4-720x540.jpg",
      barcode: 80112828,
      expiryDate: DateTime(2020, 9, 9),
      skinType: "not dry",
      ageRange: "20-25",
      location: "Boston, USA",
      secondaryImageURLs: [
        "https://www.noracooks.com/wp-content/uploads/2019/10/IMG_8457.jpg",
        "https://www.cookingclassy.com/wp-content/uploads/2019/04/whipped-cream-1.jpg",
        "https://assets.epicurious.com/photos/57631b4eff66dde1456dfed4/master/pass/sweetened-whipped-cream.jpg",
      ],
    ),
    Item(
      uid: "Assem Kassenova",
      id: "005",
      title: "Cream 112",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      imageURL:
          "https://cdn.shopify.com/s/files/1/0012/3414/1268/products/003-Hy_690x.jpg?v=1592838957",
      barcode: 80922228,
      expiryDate: DateTime(2020, 8, 8),
      skinType: "super dry",
      ageRange: "20-25",
      location: "Atlanta, Georgia, USA",
      secondaryImageURLs: [
        "https://www.noracooks.com/wp-content/uploads/2019/10/IMG_8457.jpg",
        "https://www.cookingclassy.com/wp-content/uploads/2019/04/whipped-cream-1.jpg",
        "https://betterthanbreadketo.com/wp-content/uploads/2020/01/Keto-Whipped-Cream_4-720x540.jpg",
      ],
    ),
    Item(
      uid: "Assem Ulkenova",
      id: "006",
      title: "Cream 323",
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
      imageURL:
          "https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1574444309-5dc1ccd2-0a3c-45f7-afab-2a36f6af674f-1-e73c43750a9a828f94092d2ee526bb99-1574444280.jpg",
      barcode: 83331828,
      expiryDate: DateTime(2020, 5, 12),
      skinType: "dry",
      ageRange: "20-25",
      location: "Nur-Sultan, Kazakhstan",
      secondaryImageURLs: [
        "https://www.noracooks.com/wp-content/uploads/2019/10/IMG_8457.jpg",
        "https://www.cookingclassy.com/wp-content/uploads/2019/04/whipped-cream-1.jpg",
        "https://betterthanbreadketo.com/wp-content/uploads/2020/01/Keto-Whipped-Cream_4-720x540.jpg",
      ],
    ),
  ];
}
