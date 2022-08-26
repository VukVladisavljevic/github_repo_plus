import '../../core/util/failure.dart';
import 'package:flutter/material.dart';

enum ViewState { loading, idle }

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.loading;
  Failure? error;

  ViewState get state => _state;
  bool get isLoading => _state == ViewState.loading;

  void setState(ViewState state) {
    _state = state;
    deferredNotify();
  }

  /// This enables successive runs of notifyListeners() within same function
  void deferredNotify() => Future.delayed(
        Duration.zero,
        () async {
          notifyListeners();
        },
      );
}
