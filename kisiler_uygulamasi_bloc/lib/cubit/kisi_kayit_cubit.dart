import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi_bloc/repo/Kisilerdao_repository.dart';

class KisiKayitCubit extends Cubit<void> {
  var kisirepo = KisilerdaoRepository();

  KisiKayitCubit(super.initialState);

  Future<void> kayit(String kisi_ad, String kisi_tel) async {
    await kisirepo.kisiKayit(kisi_ad, kisi_tel);
  }
}
