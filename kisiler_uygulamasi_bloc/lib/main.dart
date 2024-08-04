import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi_bloc/cubit/anasayfa_cubit.dart';
import 'package:kisiler_uygulamasi_bloc/cubit/kisi_detay_cubit.dart';
import 'package:kisiler_uygulamasi_bloc/cubit/kisi_kayit_cubit.dart';
import 'package:kisiler_uygulamasi_bloc/entity/kisiler.dart';
import 'package:kisiler_uygulamasi_bloc/views/anasayfa.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => KisiKayitCubit(0)),
        BlocProvider(create: (context) => KisiDetayCubit(0)),
        BlocProvider(create: (context) => AnasayfaCubit(<Kisiler>[])),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const Anasayfa(),
      ),
    );
  }
}
