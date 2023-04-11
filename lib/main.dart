import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/network/remote/dio_helper.dart';
import 'package:social_app/shared/styles/themes.dart';
import 'layout/cubit/cubit.dart';
import 'layout/social_layout.dart';
import 'modules/social_login/social_login_screen.dart';
import 'shared/components/bloc _observer.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('On Background messaging');
  showToast(text: 'On Background Messaging', toastStates: ToastStates.SUCCESS);
}

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showToast(text: 'On Message', toastStates: ToastStates.SUCCESS);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showToast(text: 'Message On Opening Application', toastStates: ToastStates.SUCCESS);
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData( key: 'isDark');
  bool ? onBoarding = CacheHelper.getData(key: 'onBoarding');
  late Widget startWidget;
  token = CacheHelper.getData(key: 'token');
  uId = CacheHelper.getData(key: 'uId');

  if(uId != null){
    startWidget = SocialLayout();
  }else{
    startWidget = SocialLoginScreen();
  }

  runApp(MyApp(
    isDark: isDark,
    startWidget: startWidget,
  ));
}

class MyApp extends StatelessWidget {

  final bool ? isDark;
  late Widget startWidget;
  MyApp({
    required this.isDark,
    required this.startWidget,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => SocialLayoutCubit()..getUserDate()..getPosts(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        // themeMode: cubit.dart.isDark ? ThemeMode.dark : ThemeMode.light,
        themeMode: ThemeMode.light,
        home: startWidget,
      ),
    );
  }
}