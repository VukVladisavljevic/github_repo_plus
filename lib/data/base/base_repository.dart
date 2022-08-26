import '../../core/util/failure.dart';
import '../../core/util/result.dart';

class BaseRepository {
  Result<T> resolveResult<T>(Function functionToBeResolved) {
    try {
      return Result.success(functionToBeResolved());
    } on Failure catch (failure) {
      return Result.failure(failure);
    } catch (error, stacktrace) {
      return Result.failure(Failure(error.toString(), errorTrace: stacktrace));
    }
  }

  Future<Result<T>> resolveResultAsync<T>(Future futureToBeResolved) async {
    try {
      var result = await futureToBeResolved;

      return Result.success(result);
    } on Failure catch (failure) {
      return Result.failure(failure);
    } catch (error, stacktrace) {
      return Result.failure(Failure(error.toString(), errorTrace: stacktrace));
    }
  }
}
