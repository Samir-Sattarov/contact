abstract class Repository<T> {
  Future<int> create(T item);

  Future<List<T>> getAll();

  Future<int> delete(int id);

  Future<int> update(int id, T item);
}
