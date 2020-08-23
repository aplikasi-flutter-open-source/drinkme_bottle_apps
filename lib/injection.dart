//import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:drinking_assistant/core/utils/input_converter.dart';
import 'package:drinking_assistant/core/utils/notification_helper.dart';
import 'package:drinking_assistant/features/drinking_assistant/data/data_sources/bottle_remote_data_source.dart';
import 'package:drinking_assistant/features/drinking_assistant/data/data_sources/drink_history_local_data_source.dart';
import 'package:drinking_assistant/features/drinking_assistant/data/repositories/bottle_repository_impl.dart';
import 'package:drinking_assistant/features/drinking_assistant/data/repositories/drink_repository_impl.dart';
import 'package:drinking_assistant/features/drinking_assistant/domain/repositories/bottle_repository.dart';
import 'package:drinking_assistant/features/drinking_assistant/domain/repositories/drink_repository.dart';
import 'package:drinking_assistant/features/drinking_assistant/domain/use_cases/authenticate_bottle.dart';
import 'package:drinking_assistant/features/drinking_assistant/domain/use_cases/get_drink_history.dart';
import 'package:drinking_assistant/features/drinking_assistant/domain/use_cases/init_drink_history.dart';
import 'package:drinking_assistant/features/drinking_assistant/domain/use_cases/schedule_local_notif_alarm.dart';
import 'package:drinking_assistant/features/drinking_assistant/domain/use_cases/update_drink_history.dart';
import 'package:drinking_assistant/features/drinking_assistant/presentation/manager/drink/drink_cubit.dart';
import 'package:drinking_assistant/features/drinking_assistant/presentation/manager/history/history_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart' as hive;
import 'package:http/http.dart' as http;


final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  sl.registerFactory(() => DrinkCubit(
      getDrink: sl(),
      initDrink: sl(),
      updateDrink: sl(),
      scheduleAlarm: sl(),
      authenticateBottle: sl(),
      inputConverter: sl()));
  sl.registerFactory(() => HistoryCubit(getDrinkHist: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetDrinkHistory(sl()));
  sl.registerLazySingleton(() => InitDrinkHistory(sl()));
  sl.registerLazySingleton(() => UpdateDrinkHistory(sl()));
  sl.registerLazySingleton(() => ScheduleAlarm(sl()));
  sl.registerLazySingleton(() => AuthenticateBottle(sl()));

  // Repository
  sl.registerLazySingleton<DrinkRepository>(
      () => DrinkRepositoryImpl(localDataSource: sl()));
  sl.registerLazySingleton<BottleRepository>(
      () => BottleRepositoryImpl(remoteDataSource: sl()));

  // Data Sources
  sl.registerLazySingleton<DrinkHistoryLocalDataSource>(
      () => DrinkHistoryLocalDataSourceImpl(hive: sl()));
  sl.registerLazySingleton<BottleRemoteDataSource>(
      () => BottleRemoteDataSourceImpl(client: sl()));
//  sl.registerLazySingleton<UserRemoteDataSource>(
//      () => UserRemoteDataSourceImpl(client: sl()));
//  sl.registerLazySingleton<PromoRemoteDataSource>(
//      () => PromoRemoteDataSourceImpl(client: sl()));

  // Core
//  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => NotificationHelper());
  sl.registerLazySingleton(() => InputConverter());

  // External
  sl.registerLazySingleton(() => http.Client());
//  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton(() => hive.Hive);
}
