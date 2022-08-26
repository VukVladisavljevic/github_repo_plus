import '../core/util/result.dart';

abstract class UseCaseParam<Type, Param> {
  Future<Result<Type>> call(Param param);
}
