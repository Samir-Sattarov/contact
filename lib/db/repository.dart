abstract class Repository<T> {
  Future<int> create(T item);

  Future<List<T>> getAll();

  Future delete(id);

  Future<int> update(int id, T item);
}
