import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_repository.dart';
import 'chat_repository.dart';
import 'app_router.dart';

void main() {
  final authRepository = AuthRepository();
  final chatRepository = ChatRepository();
  final appRouter = AppRouter(authRepository);

  runApp(MyApp(
    authRepository: authRepository,
    chatRepository: chatRepository,
    appRouter: appRouter,
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final ChatRepository chatRepository;
  final AppRouter appRouter;

  const MyApp({
    Key? key,
    required this.authRepository,
    required this.chatRepository,
    required this.appRouter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authRepository),
        RepositoryProvider.value(value: chatRepository),
      ],
      child: MaterialApp(
        title: 'Chat App',
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}