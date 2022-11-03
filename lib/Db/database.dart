import 'package:food_menu/Models/Recipe.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Data {
  static final Data instance = Data._init();

  static Database? _database;

  Data._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('recipes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();

    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const doubleType = 'REAL NOT NULL';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE $recipeTable (
        ${RecipeFields.id} $idType,
        ${RecipeFields.name} $textType,
        ${RecipeFields.desc} $textType,
        ${RecipeFields.price} $doubleType
      )
    ''');
  }

  Future<Recipe> create(Recipe recipe) async {
    final db = await instance.database;

    final id = await db.insert(recipeTable, recipe.toJson());
    print("sud");
    print(id);
    return recipe.copy(id: id);
  }

  Future<Recipe> getRecipe(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      recipeTable,
      columns: RecipeFields.values,
      where: '${RecipeFields.id}= ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Recipe.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Recipe>> getAllRecipes() async {
    final db = await instance.database;
    print("object");
    final result = await db.query(recipeTable);
    print(result);

    return result.map((json) => Recipe.fromJson(json)).toList();
  }

  Future<int> update(Recipe recipe) async {
    final db = await instance.database;
    return db.update(
      recipeTable,
      recipe.toJson(),
      where: '${RecipeFields.id} = ?',
      whereArgs: [recipe.id],
    );
  }

  Future<int> delete(int? id) async {
    final db = await instance.database;
    return await db.delete(
      recipeTable,
      where: '${RecipeFields.id} = ?',
      whereArgs: [id],
    );

  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
