import 'package:flutter/material.dart';
import '../model/pokemon.dart';
import '../viewmodel/api_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<Pokemon>> futurePokemon;

  @override
  void initState() {
    super.initState();
    // Memanggil API saat layar pertama kali dimuat
    futurePokemon = ApiService.fetchPokemonList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Pokedex UTS', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: FutureBuilder<List<Pokemon>>(
        future: futurePokemon,
        builder: (context, snapshot) {
          // 1. Kondisi Loading (Menunggu Data)
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.redAccent),
            );
          }
          // 2. Kondisi Error (Gagal Ambil Data)
          else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Terjadi kesalahan: ${snapshot.error}',
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }
          // 3. Kondisi Success (Data Berhasil Didapat)
          else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            final pokemonList = snapshot.data!;
            return GridView.builder(
              padding: const EdgeInsets.all(15),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 kolom
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 0.85, // Mengatur proporsi tinggi kotak
              ),
              itemCount: pokemonList.length,
              itemBuilder: (context, index) {
                final pokemon = pokemonList[index];
                return GestureDetector(
                  onTap: () {
                    // Navigasi ke halaman detail sambil membawa data pokemon
                    Navigator.pushNamed(context, '/detail', arguments: pokemon);
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.network(
                              pokemon.imageUrl,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Text(
                          pokemon.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          // Kondisi jika data kosong
          else {
            return const Center(child: Text('Tidak ada data Pokemon.'));
          }
        },
      ),
    );
  }
}