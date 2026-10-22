import 'package:flutter/material.dart';
import '../model/pokemon.dart';
import '../viewmodel/api_service.dart';

class Detail extends StatelessWidget {
  const Detail({super.key});

  @override
  Widget build(BuildContext context) {
    final Pokemon pokemon = ModalRoute.of(context)!.settings.arguments as Pokemon;

    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        title: Text(pokemon.name),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // 1. Gambar Pokemon
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 15, spreadRadius: 5)
                ]
            ),
            child: Image.network(pokemon.imageUrl, height: 160, width: 160, fit: BoxFit.cover),
          ),
          Text(
            pokemon.name,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 20),

          // 2. FutureBuilder untuk Status dan Tipe
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40)),
              ),
              child: FutureBuilder<Map<String, dynamic>>(
                future: ApiService.fetchPokemonDetail(pokemon.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: Colors.redAccent));
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Gagal memuat: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    final types = snapshot.data!['types'] as List;
                    final stats = snapshot.data!['stats'] as List;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // A. Tipe Pokemon
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: types.map((t) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.redAccent.shade100,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                t['type']['name'].toString().toUpperCase(),
                                style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 25),
                        const Text('Base Stats', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 15),

                        // B. List Progress Bar Status
                        Expanded(
                          child: ListView.builder(
                            itemCount: stats.length,
                            itemBuilder: (context, index) {
                              final statName = stats[index]['stat']['name'].toString().toUpperCase();
                              final statValue = stats[index]['base_stat'] as int;

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 15),
                                child: Row(
                                  children: [
                                    SizedBox(width: 90, child: Text(statName, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12))),
                                    SizedBox(width: 30, child: Text(statValue.toString(), style: const TextStyle(fontWeight: FontWeight.bold))),
                                    Expanded(
                                      child: LinearProgressIndicator(
                                        value: statValue / 150, // asumsi maksimal stat adalah 150
                                        backgroundColor: Colors.grey.shade200,
                                        color: statValue > 50 ? Colors.green : Colors.red,
                                        minHeight: 8,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}