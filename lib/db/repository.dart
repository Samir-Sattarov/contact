abstract class Repository<T> {
  Future create(T item);

  Future<List<T>> getAll();

  Future delete(id);

  Future update(id, T item);

  Future<void> deleteAll();
}
