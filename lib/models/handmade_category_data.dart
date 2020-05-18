class HandmadeCategoryData {
  HandmadeCategoryData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.meals,
    this.kacl = 0,
  });

  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  List<String> meals;
  int kacl;

  static List<HandmadeCategoryData> tabIconsList = <HandmadeCategoryData>[
    HandmadeCategoryData(
      imagePath: 'assets/fitness_app/breakfast.png',
      titleTxt: 'Food',
      kacl: 525,
      meals: <String>['Bread,', 'Peanut butter,', 'Apple'],
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    HandmadeCategoryData(
      imagePath: 'assets/fitness_app/lunch.png',
      titleTxt: 'Leather',
      kacl: 602,
      meals: <String>['Salmon,', 'Mixed veggies,', 'Avocado'],
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ),
    HandmadeCategoryData(
      imagePath: 'assets/fitness_app/snack.png',
      titleTxt: 'Ceramic',
      kacl: 0,
      meals: <String>['Recommend:', '800 kcal'],
      startColor: '#FE95B6',
      endColor: '#FF5287',
    ),
    HandmadeCategoryData(
      imagePath: 'assets/fitness_app/dinner.png',
      titleTxt: 'Clothes',
      kacl: 0,
      meals: <String>['Recommend:', '703 kcal'],
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
  ];
}
