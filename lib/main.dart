import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:viswals_flutter_interview_task/services/countries_service.dart';
import 'package:viswals_flutter_interview_task/services/file_pick_service.dart';
import 'package:viswals_flutter_interview_task/state/user_profile_provider.dart';
import 'package:viswals_flutter_interview_task/ui/screens/user_profile/user_profile_screen.dart';
import 'package:viswals_flutter_interview_task/ui/style/system_ui_overlay.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<CountriesService>(create: (_) => CountriesService()),
        Provider<FilePickService>(create: (_) => FilePickService()),
        ChangeNotifierProvider<UserProfileProvider>(
          create: (_) => UserProfileProvider(),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(systemUIOverlayStyle);

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserProfileScreen(),
    );
  }
}
