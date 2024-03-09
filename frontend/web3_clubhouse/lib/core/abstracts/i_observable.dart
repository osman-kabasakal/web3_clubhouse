typedef void Subscriber<T>(T val, T preVal);

abstract class IObservable<T> {
  T get value;
  set value(T val);
  String subscribe(Subscriber<T> cb);
  void removeSubscribe(String id);
  void removeAllSubscribe();
  String singleSubscribe(void Function(T, T) cb);
  int subscribeCount();
}
