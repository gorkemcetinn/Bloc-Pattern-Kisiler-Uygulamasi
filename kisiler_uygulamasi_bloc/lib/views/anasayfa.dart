import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kisiler_uygulamasi_bloc/cubit/anasayfa_cubit.dart';
import 'package:kisiler_uygulamasi_bloc/entity/kisiler.dart';
import 'package:kisiler_uygulamasi_bloc/views/kisi_detay_sayfa.dart';
import 'package:kisiler_uygulamasi_bloc/views/kisi_kayit_sayfa.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _Anasayfa();
}

class _Anasayfa extends State<Anasayfa> {
  late bool isSearch = false;

  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().kisileriYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearch
            // TRUE İSE BURASI ÇALIŞACAK
            ? TextField(
                decoration: const InputDecoration(
                  hintText: 'Ara',
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (aramaSonucu) {
                  context.read<AnasayfaCubit>().ara(aramaSonucu);
                },
              )
            //FALSE İSE BURASI
            : const Text(
                "Kişiler",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearch = !isSearch;
                context.read<AnasayfaCubit>().kisileriYukle();
              });
            },
            icon: Icon(isSearch ? Icons.close : Icons.search),
            color: Colors.white,
          ),
        ],
        backgroundColor: Colors.black,
      ),
      body: BlocBuilder<AnasayfaCubit, List<Kisiler>>(
        builder: (context, kisilerListesi) {
          if (kisilerListesi.isNotEmpty) {
            return ListView.builder(
              itemCount: kisilerListesi.length,
              itemBuilder: (BuildContext context, int index) {
                var kisi = kisilerListesi[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => KisiDetaySayfa(
                                  kisi: kisi,
                                )),
                      ).then((value) {
                        print("Ana sayfaya dönüldü");
                      });
                    },
                    child: Card(
                      color: Colors.grey[200],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "${kisi.kisi_id}) ${kisi.kisi_ad} - ${kisi.kisi_tel}",
                              style: const TextStyle(fontSize: 16),
                            ),
                            const Spacer(), // Row içindeki öğeleri yaymak için Spacer kullanıyoruz
                            IconButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content:
                                      Text("${kisi.kisi_ad} silinsin mi ?"),
                                  action: SnackBarAction(
                                    label: "EVET",
                                    onPressed: () {
                                      context
                                          .read<AnasayfaCubit>()
                                          .sil(kisi.kisi_id);
                                    },
                                  ),
                                ));
                              },
                              icon: const Icon(Icons.delete_outline),
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text("Kişi bulunamadı."),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Ekleye Basıldı");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const KisiKayitSayfa()),
          ).then((value) {
            print("Ana sayfaya dönüldü");
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
