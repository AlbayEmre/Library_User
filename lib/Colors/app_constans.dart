//İmageler burda

import '../Model/catogories_models.dart';
import '../Services/Assets_Manager.dart';

class AppConstans {
  static const imageUrl =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkAhvc-YjdwsimlEYdOknxcvbgNOVSHWjkWQ&s';

  static const BeyazDis = "https://www.ilknokta.com/u/ilknokta/img/c/b/e/beyaz-dis-klasik-1657091053.jpg";

  static List<String> bannerImage = [
    //!Bu ersimler ana ekrandaki banner resimleri deyişecek
    AssetsManager.slide1,
    AssetsManager.slide2,
    AssetsManager.slide3,
    AssetsManager.slide4,
    AssetsManager.slide5,
    AssetsManager.slide6,
  ];
  static List<CatogoriesModel> cotogoriesList = [
    CatogoriesModel(id: "Scientific", name: "Scientific", image: AssetsManager.bilimsel),
    CatogoriesModel(id: "Dystopian", name: "Dystopian", image: AssetsManager.distopik),
    CatogoriesModel(id: "Fantastic", name: "Fantastic", image: AssetsManager.fantastik),
    CatogoriesModel(id: "Classical", name: "Classical", image: AssetsManager.klasik),
    CatogoriesModel(id: "Historical", name: "Historical", image: AssetsManager.tarihi),
    CatogoriesModel(id: "Thriller and crime", name: "ThrillerAndCrime", image: AssetsManager.gerilim_Ve_Suc),
  ];
}
