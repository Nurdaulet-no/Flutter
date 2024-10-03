import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/clothes.dart';

class ClothesProvider with ChangeNotifier{
  List<Clothes> _clothesList = [];

  List<Clothes> get clothesList => _clothesList;
  
  ClothesProvider() {
    loadClothes();
  }

  // Load clothes from Hive
  Future<void> loadClothes() async {
    final box = Hive.box<Clothes>('clothesBox');
    _clothesList = box.values.toList();
    notifyListeners();
  }

  // Add new clothes
  Future<void> addClothes(Clothes clothes) async {
    final box = Hive.box<Clothes>('clothesBox');
    await box.add(clothes);
    _clothesList = box.values.toList();
    notifyListeners();
  }

  // Update clothes
  Future<void> updateClothes(int index, Clothes clothes) async{
    final box = Hive.box<Clothes>('clothesBox');
    await box.put(index, clothes);
    _clothesList = box.values.toList();
    notifyListeners();
  }

  // Delete clothes
  Future<void> deleteClothes(int index) async {
    final box = Hive.box<Clothes>('clothesBox');
    await box.delete(index);
    _clothesList = box.values.toList();
    notifyListeners();
  }
}