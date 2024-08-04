import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kisiler_uygulamasi_bloc/entity/kisiler.dart';

class KisilerdaoRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> kisiKayit(String kisi_ad, String kisi_tel) async {
    await _firestore.collection("kisiler").add({
      "kisi_ad": kisi_ad,
      "kisi_tel": kisi_tel,
    });
  }

  Future<void> kisiGuncelle(
      int kisi_id, String kisi_ad, String kisi_tel) async {
    var document = _firestore.collection("kisiler").doc(kisi_id.toString());
    await document.update({
      "kisi_ad": kisi_ad,
      "kisi_tel": kisi_tel,
    });
  }

  Future<List<Kisiler>> tumKisileriAl() async {
    var snapshot = await _firestore.collection("kisiler").get();
    var kisilerListesi = snapshot.docs.map((doc) {
      var data = doc.data();
      return Kisiler(
        kisi_id: int.parse(doc.id),
        kisi_ad: data['kisi_ad'],
        kisi_tel: data['kisi_tel'],
      );
    }).toList();
    return kisilerListesi;
  }

  Future<List<Kisiler>> kisiAra(String aramaKelimesi) async {
    var snapshot = await _firestore
        .collection("kisiler")
        .where("kisi_ad", isGreaterThanOrEqualTo: aramaKelimesi)
        .where("kisi_ad", isLessThanOrEqualTo: aramaKelimesi + '\uf8ff')
        .get();
    var kisilerListesi = snapshot.docs.map((doc) {
      var data = doc.data();
      return Kisiler(
        kisi_id: int.parse(doc.id),
        kisi_ad: data['kisi_ad'],
        kisi_tel: data['kisi_tel'],
      );
    }).toList();
    return kisilerListesi;
  }

  Future<void> kisiSil(int kisi_id) async {
    await _firestore.collection("kisiler").doc(kisi_id.toString()).delete();
  }
}
