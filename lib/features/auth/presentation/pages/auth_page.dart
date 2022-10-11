import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:obateru_joshua_weight_tracker_app/core/widgets/app_progress_indicator.dart';
import 'package:obateru_joshua_weight_tracker_app/core/widgets/text_button.dart';
import 'package:obateru_joshua_weight_tracker_app/features/auth/bloc/auth_bloc.dart';
import 'package:obateru_joshua_weight_tracker_app/values/colors.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          width: size.width,
          height: size.height,
          color: appPrimaryColor,
          child: BlocListener<AuthBloc, AuthState>(listener: (context, state) {
            if (state is Authenticated) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/weight_tracker', (route) => false);
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          }, child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Center(child: const AppProgressIndicator());
              } else {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Spacer(
                        flex: 3,
                      ),
                      Text(
                        'Welcome to Your Personalized Weight Tracker',
                        style: TextStyle(
                            color: appWhite,
                            fontWeight: FontWeight.w900,
                            fontSize: size.width * 0.08),
                        textAlign: TextAlign.center,
                      ),
                      Spacer(),
                      Text(
                        'Keep track of your weight changes,\n to avoid surprises 😊',
                        style: TextStyle(
                            color: appWhite,
                            fontWeight: FontWeight.w300,
                            fontSize: size.width * 0.045),
                        textAlign: TextAlign.center,
                      ),
                      Spacer(
                        flex: 3,
                      ),
                      SignInButton(
                        Buttons.Google,
                        text: 'Sign in with Google',
                        onPressed: () {
                          BlocProvider.of<AuthBloc>(context)
                              .add(SignInUserWithGoogleEvent());
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(size.width * 0.2)),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: CustomTextButton(
                            size: size,
                            label: 'Sign In as Guest',
                            onPressed: () {
                              BlocProvider.of<AuthBloc>(context)
                                  .add(SignInAnonymousUserEvent());
                            },
                          )),
                      Spacer(
                        flex: 3,
                      ),
                    ],
                  ),
                );
              }
            },
          ))),
    );
  }
}
