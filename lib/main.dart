import 'core/service_locator/service_locator.dart';
import 'feature/login/presenter/cubits/login_cubit.dart';
import 'feature/login/presenter/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  initServiceLocator();
  runApp(const MyPokedex());
}

class MyPokedex extends StatelessWidget {
  const MyPokedex({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clean Pokedex',
      home: BlocProvider(
        create: (_) => getIt<LoginCubit>(),
        child: const LoginPage(),
      ),
    );
  }
}
