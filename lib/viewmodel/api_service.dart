import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/pokemon.dart';

class ApiService {
  // Fungsi 1: Untuk halaman Home (Daftar Awal)
  static Future<List<Pokemon>> fetchPokemonList() async {
    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=20');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];

      List<Pokemon> pokemonList = [];
      for (int i = 0; i < results.length; i++) {
        pokemonList.add(Pokemon.fromJson(results[i], i + 1));
      }
      return pokemonList;
    } else {
      throw Exception('Gagal mengambil data dari API Pokemon');
    }
  }

  // Fungsi 2: BARU! Untuk halaman Detail (Mengambil Statistik & Tipe)
  static Future<Map<String, dynamic>> fetchPokemonDetail(int id) async {
    final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Gagal memuat detail status');
    }
  }
}