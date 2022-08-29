import '../../core/util/failure.dart';
import 'package:flutter/material.dart';

enum ViewState { Loading, Idle, Failed }

class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.Idle;
  Failure? error;

  ViewState get state => _state;
  bool get isLoading => _state == ViewState.Loading;
  bool get isFailed => _state == ViewState.Failed;

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
