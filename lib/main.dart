import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:task/features/splash/screens/splash_screen.dart';
import 'package:task/global/bloc_providers/bloc_providers.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();




  await dotenv.load(fileName: "assets/.env");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: BlocProviders.providers,
      child: const CupertinoApp(
        debugShowCheckedModeBanner: false,
        title: 'Ulearna Task',
        home: SplashScreen(),
      ),
    );
  }
}
