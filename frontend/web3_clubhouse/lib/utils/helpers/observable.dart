
import 'package:web3_clubhouse/utils/helpers/common.dart';

import '../../core/abstracts/i_observable.dart';

class Observable<T> implements IObservable<T> {
  Observable(T val) {
    this._prevVal = val;
    this._propVal = val;
  }

  late T _propVal;

  late T _prevVal;

  @override
  T get value {
    return this._propVal;
  }

  @override
  set value(T newVal) {
    this._prevVal = this._propVal;
    this._propVal = newVal;
    this._notifySubscriber();
  }

  Map<String, void Function(T newVal, T prevVal)> _subscriberList =
      Map.identity();
  Map<String, void Function(T newVal, T prevVal)> _singleSubscriber =
      Map.identity();

  void _notifySubscriber() {
    if (this._subscriberList != null && this._subscriberList.isNotEmpty) {
      this
          ._subscriberList
          .forEach((key, val) => val(this._propVal, this._prevVal));
    }
    if (this._singleSubscriber != null && this._singleSubscriber.isNotEmpty) {
      this
          ._singleSubscriber
          .forEach((key, val) => val(this._propVal, this._prevVal));
    }
    this._singleSubscriber.clear();
  }

  @override
  String subscribe(void Function(T, T) cb) {
    if (this._subscriberList == null) {
      this._subscriberList = Map.identity();
    }
    var key = CommonHelper.createUniqueCryptoRandomString(
        arr: this._subscriberList.keys.toList());
    this._subscriberList[key] = cb;
    cb(this._propVal, this._prevVal);
    return key;
  }

  @override
  String singleSubscribe(void Function(T newVal, T oldVal) cb) {
    if (this._singleSubscriber == null) {
      this._singleSubscriber = Map.identity();
    }
    var key = CommonHelper.createUniqueCryptoRandomString(
        arr: this._singleSubscriber.keys.toList());
    this._singleSubscriber[key] = cb;
    cb(this._propVal, this._prevVal);
    return key;
  }

  @override
  void removeSubscribe(String key) {
    if (this._subscriberList.containsKey(key)) {
      this._subscriberList.remove(key);
    }
  }

  @override
  void removeAllSubscribe() {
    if (this._subscriberList != null) {
      this._subscriberList.clear();
    }
  }

  @override
  int subscribeCount() {
    return this._subscriberList.length;
  }
}
