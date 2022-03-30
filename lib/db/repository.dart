abstract class Repository<T> {
  Future<int> create(T item);

  Future<List<T>> getAll();

  Future delete(id);

  Future update(id, T item);
}
