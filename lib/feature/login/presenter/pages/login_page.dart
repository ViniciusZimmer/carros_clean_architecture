import 'package:clean_cars/feature/login/domain/entities/login_request_entity.dart';
import 'package:clean_cars/feature/login/presenter/cubits/login_cubit.dart';
import 'package:clean_cars/feature/login/presenter/cubits/login_state.dart';
import 'package:clean_cars/feature/login/presenter/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/service_locator/service_locator.dart';
import '../../../cars/presenter/cubits/cars_cubit.dart';
import '../../../cars/presenter/pages/cars_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bg_login.jpeg'),
                fit: BoxFit.cover)),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(32),
              child: Image.asset('assets/images/logo_nf.png',
                  key: const Key('nf-logo-image'), width: 120, height: 120),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              style: const TextStyle(color: Colors.black),
              key: const Key('textfield-login'),
              controller: _loginController,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.white,
                label: Text('Login'),
                labelStyle: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              style: const TextStyle(color: Colors.black),
              key: const Key('textfield-password'),
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  label: Text('Password'),
                  labelStyle: TextStyle(
                    color: Colors.black,
                  )),
            ),
            const SizedBox(
              height: 32,
            ),
            BlocConsumer<LoginCubit, LoginState>(
              listener: (context, state) {
                // _listener(state, context);
              },
              builder: (context, state) {
                final bool isLoadingState = state is LoginLoadingState;
                return AppButton(
                  key: const Key('button-login'),
                  text: 'Login',
                  onPressed: () {
                    _onPressedLogin(context);
                  },
                  showProgress: isLoadingState,
                );
              },
            )
          ],
        ),
      ),
    );
  }

  void _onPressedLogin(BuildContext context) {
    final request = LoginRequestEntity(
      login: _loginController.text,
      password: _passwordController.text,
    );

    context.read<LoginCubit>().doLogin(request);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => getIt<CarsCubit>()..getCars(),
          child: const CarsPage(),
        ),
      ),
    );
  }

  // void _listener(LoginState state, BuildContext context) {
  //   if (state is LoginErrorState) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(
  //           state.errorMessage,
  //         ),
  //       ),
  //     );
  //   }
  // }
}
