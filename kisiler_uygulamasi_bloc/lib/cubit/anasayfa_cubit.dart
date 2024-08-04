import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi_bloc/entity/kisiler.dart';
import 'package:kisiler_uygulamasi_bloc/repo/Kisilerdao_repository.dart';

class AnasayfaCubit extends Cubit<List<Kisiler>> {
  var krepo = KisilerdaoRepository();

  AnasayfaCubit(super.initialState);

  Future<void> kisileriYukle() async {
    var liste = await krepo.tumKisileriAl();
    emit(liste);
  }

  Future<void> ara(String aramaKelimesi) async {
    var liste = await krepo.kisiAra(aramaKelimesi);
    emit(liste);
  }

  Future<void> sil(int kisi_id) async {
    await krepo.kisiSil(kisi_id);
    await kisileriYukle();
  }
}
