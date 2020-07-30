import 'package:zenithbankkyc/bloc/login_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:zenithbankkyc/domain/usecases/staff_login_use_case.dart';
import 'package:zenithbankkyc/domain/repositories/agent_login_repository.dart';
import 'package:zenithbankkyc/data/repository/agent_login_repository_impl.dart';
import 'package:zenithbankkyc/data/datasources/agent_login_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:data_connection_checker/data_connection_checker.dart';

final sl = GetIt.instance;
void init() {
  sl.registerFactory(() => LoginBloc(
        loginUseCase: sl(),
      ));

  // register usecase
  sl.registerLazySingleton(() => StaffLoginUseCase(repository: sl()));
  // register repository
  sl.registerLazySingleton<AgentLoginRepository>(() => AgentLoginRepositoryImpl(
        agentLoginRemoteData: sl(),
        networkInfo: sl(),
      ));
  // register external dependencies
  sl.registerLazySingleton<AgentLoginRemoteData>(() => AgentLoginRemoteDataImpl(
        httpClient: sl(),
      ));
  // register concrete external libraries

  sl.registerLazySingleton(()  => http.Client);
  sl.registerLazySingleton(()  => DataConnectionChecker());

}
