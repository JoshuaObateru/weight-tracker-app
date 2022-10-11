import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:obateru_joshua_weight_tracker_app/core/widgets/app_progress_indicator.dart';
import 'package:obateru_joshua_weight_tracker_app/core/widgets/text_button.dart';
import 'package:obateru_joshua_weight_tracker_app/features/auth/bloc/auth_bloc.dart';
import 'package:obateru_joshua_weight_tracker_app/values/colors.dart';

class SignOutConfirmation extends StatelessWidget {
  const SignOutConfirmation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "If you sign out now, all your data will be lost. Sign in with google to save your data for when next you come back",
          style: TextStyle(color: appWhite),
          textAlign: TextAlign.center,
        ),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is UnAuthenticated) {
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
            if (state is GoogleAuthenticated) {
              BlocProvider.of<AuthBloc>(context).add(SignOutUserEvent());
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(builder: ((context, state) {
            if (state is AuthLoading) {
              return const Padding(
                padding: EdgeInsets.all(8.0),
                child: AppProgressIndicator(),
              );
            } else {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SignInButton(
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
                  ),
                  CustomTextButton(
                    size: size,
                    label: 'Sign Out',
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context)
                          .add(SignOutUserEvent());
                    },
                  )
                ],
              );
            }
          })),
        ),
      ],
    );
  }
}
