class Pokemon {
  final int id;
  final String name;
  final String imageUrl;

  Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  // Mengonversi data JSON dari API menjadi Objek Dart
  factory Pokemon.fromJson(Map<String, dynamic> json, int index) {
    return Pokemon(
      id: index,
      name: json['name'].toString().toUpperCase(), // Nama pokemon dibuat kapital
      // Mengambil gambar HD resmi berdasarkan ID
      imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$index.png',
    );
  }
}