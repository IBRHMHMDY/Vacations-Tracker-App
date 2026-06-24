import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../../core/usecases/base_usecase.dart';
import '../repositories/leave_repository.dart';

class ResetLeavesUseCase implements BaseUseCase<Unit, NoParams> {
  final LeaveRepository repository;

  ResetLeavesUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return await repository.deleteAllLeaves();
  }
}