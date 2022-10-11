import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:obateru_joshua_weight_tracker_app/features/auth/bloc/auth_bloc.dart';
import 'package:obateru_joshua_weight_tracker_app/features/weight_tracker/bloc/fetch_weights_bloc.dart';
import 'package:obateru_joshua_weight_tracker_app/features/weight_tracker/bloc/weight_tracker_bloc.dart';
import 'package:obateru_joshua_weight_tracker_app/injector.dart';
import 'package:obateru_joshua_weight_tracker_app/routes/router.dart';
import 'package:obateru_joshua_weight_tracker_app/values/colors.dart';
import 'injector.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  await di.init();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  sl<AuthBloc>()..add(CheckUserSignInStatus())),
          BlocProvider(create: (context) => sl<WeightTrackerBloc>()),
          BlocProvider(create: (context) => sl<FetchWeightsBloc>()),
        ],
        child: MaterialApp(
          title: 'Weight Tracker App',
          theme: ThemeData(
            primarySwatch: appPrimaryColor,
          ),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.generateRoute,
          initialRoute: '/',
        ));
  }
}
