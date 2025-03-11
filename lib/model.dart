class RecipeModel {
  late String appLabel;
  late String appImgUrl;
  late double appCalories;
  late String appUrl;
  RecipeModel(
      {this.appLabel = "Label",
      this.appImgUrl = "Image",
      this.appCalories = 0.000,
      this.appUrl = "Url"});
  factory RecipeModel.fromMap(Map recipe) {
    return RecipeModel(
      appLabel: recipe['label'],
      appCalories: recipe['calories'],
      appImgUrl: recipe['image'],
      appUrl: recipe['url'],
    );
  }
}
