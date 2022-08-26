import 'failure.dart';
import 'package:equatable/equatable.dart';

/// This abstraction contains either a success data of generic type `S` or a
/// failure error of type `Failure` as its result.
///
/// `data` property must only be retrieved when `DataResult` was constructed by
/// using `DataResult.success(value)`. It can be validated by calling
/// `isSuccess` first. Alternatively, `dataOrElse` can be used instead since it
/// ensures a valid value is returned in case the result is a failure.
///
/// `error` must only be retrieved when `DataResult` was constructed by using
/// `DataResult.failure(error)`. It can be validated by calling `isFailure`
/// first.
abstract class Result<S> extends Equatable {
  static Result<S> failure<S>(Failure failure) => _FailureResult(failure);

  static Result<S> success<S>(S data) => _SuccessResult(data);

  Failure? get error => fold<Failure?>((error) => error, (data) => null);

  S? get data => fold<S?>((error) => null, (data) => data);

  bool get isSuccess => this is _SuccessResult<S>;

  bool get isFailure => this is _FailureResult<S>;

  S dataOrElse(S other) => isSuccess && data != null ? data! : other;

  Result<T> either<T>(Failure Function(Failure error) fnFailure, T Function(S data) fnData);

  Result<T> then<T>(Result<T> Function(S data) fnData);

  Result<T> map<T>(T Function(S data) fnData);

  T fold<T>(T Function(Failure error) fnFailure, T Function(S data) fnData);

  @override
  List<Object?> get props => [if (isSuccess) data else error];
}

class _SuccessResult<S> extends Result<S> {
  final S _value;

  _SuccessResult(this._value);

  @override
  _SuccessResult<T> either<T>(Failure Function(Failure error) fnFailure, T Function(S data) fnData) =>
      _SuccessResult<T>(fnData(_value));

  @override
  Result<T> then<T>(Result<T> Function(S data) fnData) => fnData(_value);

  @override
  _SuccessResult<T> map<T>(T Function(S data) fnData) => _SuccessResult<T>(fnData(_value));

  @override
  T fold<T>(T Function(Failure error) fnFailure, T Function(S data) fnData) => fnData(_value);
}

class _FailureResult<S> extends Result<S> {
  final Failure _value;

  _FailureResult(this._value);

  @override
  _FailureResult<T> either<T>(Failure Function(Failure error) fnFailure, T Function(S data) fnData) =>
      _FailureResult<T>(fnFailure(_value));

  @override
  _FailureResult<T> map<T>(T Function(S data) fnData) => _FailureResult<T>(_value);

  @override
  _FailureResult<T> then<T>(Result<T> Function(S data) fnData) => _FailureResult<T>(_value);

  @override
  T fold<T>(T Function(Failure error) fnFailure, T Function(S data) fnData) => fnFailure(_value);
}
