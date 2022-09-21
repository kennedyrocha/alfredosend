import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:sendify/features/analytics/data/datasource/analytics_remote_datasource.dart';
import 'package:sendify/features/analytics/data/repository/analytics_repository_impl.dart';
import 'package:sendify/features/analytics/domain/repository/analytics_repository.dart';
import 'package:sendify/features/analytics/domain/usecase/get_notifications.dart';
import 'package:sendify/features/analytics/presentation/bloc/analytics_bloc.dart';
import 'package:sendify/features/send/data/datasource/send_remote_datasource.dart';
import 'package:sendify/features/send/data/repository/send_repository_impl.dart';
import 'package:sendify/features/send/domain/repository/send_repository.dart';
import 'package:sendify/features/send/domain/usecase/send.dart';
import 'package:sendify/features/send/presentation/bloc/send_bloc.dart';
import 'package:sendify/features/templates/data/datasource/templates_remote_datasource.dart';
import 'package:sendify/features/templates/data/repository/templates_repository_impl.dart';
import 'package:sendify/features/templates/domain/repository/templates_repository.dart';
import 'package:sendify/features/templates/domain/usecase/get_templates.dart';
import 'package:sendify/features/templates/domain/usecase/send_notification_by_template_id.dart';
import 'package:sendify/features/templates/presentation/bloc/templates_bloc.dart';

final sl = GetIt.instance;

init() {
  /*
  * Send notification  dependencies
  * Bloc
  */

  sl.registerFactory(
        () => SendBloc(sl()),
  );

  //UseCases
  sl.registerLazySingleton(
        () => Send(
      sl(),
    ),
  );

  //Repositories
  sl.registerLazySingleton<SendRepository>(
        () => SendRepositoryImpl(sl(),),
  );

  // DataSources
  sl.registerLazySingleton<SendRemoteDataSource>(
        () => SendRemoteDataSourceImpl(sl()),
  );


  /*
  * Notifications  dependencies
  * Bloc
  */

  sl.registerFactory(
        () => AnalyticsBloc(sl()),
  );

  //UseCases
  sl.registerLazySingleton(
        () => GetNotifications(
      sl(),
    ),
  );

  //Repositories
  sl.registerLazySingleton<AnalyticsRepository>(
        () => AnalyticsRepositoryImpl(sl(),),
  );

  // DataSources
  sl.registerLazySingleton<AnalyticsRemoteDataSource>(
        () => AnalyticsRemoteDataSourceImpl(sl()),
  );


  /*
  * Templates dependencies
  * Bloc
  */

  sl.registerFactory(
        () => TemplatesBloc(sl(), sl()),
  );

  //UseCases
  sl.registerLazySingleton(
        () => GetTemplates(
      sl(),
    ),
  );

  sl.registerLazySingleton(
        () => SendNotificationByTemplateId(
      sl(),
    ),
  );

  //Repositories
  sl.registerLazySingleton<TemplatesRepository>(
        () => TemplatesRepositoryImpl(sl(),),
  );

  // DataSources
  sl.registerLazySingleton<TemplatesRemoteDataSource>(
        () => TemplatesRemoteDataSourceImpl(sl()),
  );



  //modules
  sl.registerFactory(
        () => Dio(),
  );

}