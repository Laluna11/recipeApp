
const recipeTable = 'recipes';

class RecipeFields{
  static final List<String> values =[
    id , name , desc , price
  ];

  static const String id ='_id';
  static const String name ='name';
  static const String desc ='desc';
  static const String price ='price';

}

class Recipe {
  int? id;
  String name;
  String desc;
  double price;

  Recipe({
    this.id,
    required this.name,
    required this.desc,
    required this.price,
  });

  Recipe copy({
    int? id,
    String? name,
    String? desc,
    double? price,
  })=>
      Recipe(
        id: id ?? this.id,
        name: name ?? this.name,
        desc: desc ?? this.desc,
        price: price?? this.price,
      );
  static Recipe fromJson(Map<String , Object?> json)=>Recipe(
    id: json[RecipeFields.id] as int?,
    name: json[RecipeFields.name] as String,
    desc: json[RecipeFields.desc] as String,
    price: json[RecipeFields.price] as double,
  );


  Map<String , Object?> toJson()=>{
    RecipeFields.id: id,
    RecipeFields.name:name,
    RecipeFields.desc:desc,
    RecipeFields.price: price,

  };

}
