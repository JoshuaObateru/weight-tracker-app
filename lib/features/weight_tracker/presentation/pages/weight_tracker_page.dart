import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:intl/intl.dart';
import 'package:obateru_joshua_weight_tracker_app/core/widgets/app_progress_indicator.dart';
import 'package:obateru_joshua_weight_tracker_app/core/widgets/text_button.dart';
import 'package:obateru_joshua_weight_tracker_app/features/auth/bloc/auth_bloc.dart';
import 'package:obateru_joshua_weight_tracker_app/features/weight_tracker/bloc/fetch_weights_bloc.dart';
import 'package:obateru_joshua_weight_tracker_app/features/weight_tracker/bloc/weight_tracker_bloc.dart';
import 'package:obateru_joshua_weight_tracker_app/features/weight_tracker/presentation/helpers.dart';
import 'package:obateru_joshua_weight_tracker_app/features/weight_tracker/presentation/widgets/add_weight_widget.dart';
import 'package:obateru_joshua_weight_tracker_app/features/weight_tracker/presentation/widgets/edit_weight_widget.dart';
import 'package:obateru_joshua_weight_tracker_app/features/weight_tracker/presentation/widgets/sign_out_confirmation.dart';
import 'package:obateru_joshua_weight_tracker_app/values/colors.dart';

class WeightTrackerPage extends StatefulWidget {
  const WeightTrackerPage({Key? key}) : super(key: key);

  @override
  _WeightTrackerPageState createState() => _WeightTrackerPageState();
}

class _WeightTrackerPageState extends State<WeightTrackerPage> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FetchWeightsBloc>(context).add(GetFetchWeightsEvent());
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) => buildPopupDialog(
                context, size, 'Add Weight', AddWeightWidget()),
          );
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Weights',
          style: TextStyle(color: appWhite),
        ),
        actions: [
          Center(
            child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: BlocConsumer<AuthBloc, AuthState>(
                    builder: (context, state) {
                  if (state is Authenticated) {
                    if (state.user.isAnonymous) {
                      return CustomTextButton(
                        size: size,
                        label: 'Sign Out 🚶🏻',
                        fontWeight: FontWeight.w300,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => buildPopupDialog(
                                context, size, 'Hey!', SignOutConfirmation()),
                          );
                        },
                        // color: appWhite.withOpacity(0.9),
                      );
                    } else {
                      return CustomTextButton(
                        size: size,
                        label: 'Sign Out 🚶🏻',
                        fontWeight: FontWeight.w300,
                        onPressed: () {
                          BlocProvider.of<AuthBloc>(context)
                              .add(SignOutUserEvent());
                        },
                        // color: appWhite.withOpacity(0.9),
                      );
                    }
                  } else if (state is AuthLoading) {
                    return const AppProgressIndicator();
                  }
                  return CustomTextButton(
                    size: size,
                    label: 'Sign Out 🚶🏻',
                    fontWeight: FontWeight.w300,
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context)
                          .add(CheckUserSignInStatus());
                    },
                    // color: appWhite.withOpacity(0.9),
                  );
                }, listener: (context, state) {
                  if (state is AuthError) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                  } else if (state is UnAuthenticated) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (route) => false);
                  }
                })),
          )
        ],
      ),
      body: Container(
        color: appWhite,
        width: size.width,
        height: size.height,
        child: BlocBuilder<FetchWeightsBloc, FetchWeightsState>(
          builder: (context, state) {
            if (state is FetchWeightTrackerLoaded) {
              if (state.weights.isEmpty) {
                return Center(
                  child: Text("No weights added"),
                );
              }
              return ListView.builder(
                  itemCount: state.weights.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: appPrimaryColor.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(16)),
                        child: ListTile(
                          leading: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    buildPopupDialog(
                                        context,
                                        size,
                                        'Edit Weight!',
                                        EditWeightWidget(
                                          existingWeight:
                                              state.weights[index].weight!,
                                          id: state.weights[index].id!,
                                          timestamp:
                                              state.weights[index].timeStamp!,
                                        )),
                              );
                            },
                            icon: Icon(
                              Icons.edit,
                              color: appWhite,
                            ),
                          ),
                          title: Text(
                            "${state.weights[index].weight}(kg)",
                            style: TextStyle(color: appWhite),
                          ),
                          subtitle: Text(
                            "${DateFormat.yMMMMEEEEd().format(state.weights[index].timeStamp!.toDate())} ${DateFormat.jm().format(state.weights[index].timeStamp!.toDate())}",
                            style: TextStyle(color: appWhite),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              BlocProvider.of<WeightTrackerBloc>(context).add(
                                  DeleteWeightByIdEvent(
                                      id: state.weights[index].id!));
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    );
                  });
            } else if (state is FetchWeightTrackerLoading) {
              return const Center(
                child: AppProgressIndicator(),
              );
            } else if (state is FetchWeightTrackerError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("${state.message}"),
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
