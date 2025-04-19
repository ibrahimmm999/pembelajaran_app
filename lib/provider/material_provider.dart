import 'package:flutter/cupertino.dart';
import 'package:pwa_ngajar/models/material_model.dart';
import 'package:pwa_ngajar/services/material_service.dart';

class MaterialProvider extends ChangeNotifier {
  List<MaterialModel> materials = [];
  bool loading = false;

  void addMaterial(MaterialModel material) {
    materials.add(material);
    notifyListeners();
  }

  void setLoading(bool newLoading) {
    loading = newLoading;
    notifyListeners();
  }

  Future<void> getMaterial() async {
    try {
      final cek = await MaterialService().getMaterial();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
