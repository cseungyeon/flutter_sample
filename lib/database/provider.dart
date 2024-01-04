
// typedef MapperFunction<T> = T Function(Map<String, dynamic> json);

// class Provider<T> {
//   final Database _db;
//   final String _tableName;

//   Provider({required tableName}) : _tableName = tableName;

//   Future<int> insert(Map<String, Object?> map) async {
//     return await _db.insert(_tableName, map);
//   }

//   Future<T> get(int columnId, int id) async {
//     return await _db.query(_tableName, where: '$columnId = $id');
//   }

//   Future<List<T>> getAll(MapperFunction<T> mapper) async {
//     List<Map<String, dynamic>> maps = await _db.query(_tableName);
//     return maps.map((json) => mapper(json)).toList();
//   }

//   Future<int> delete(int id) async {}

//   Future<int> update(T data) async {}
// }
