import 'package:supabase_flutter/supabase_flutter.dart';

class MaterialService {
  final _supabase = Supabase.instance.client;

  Future<bool> getMaterial() async {
    try {
      print("material service");
      final material = _supabase.from('materials').select();
      print(material);

      return true;
    } catch (e) {
      print("material service error");
      print(e);
      rethrow;
    }
  }
}
