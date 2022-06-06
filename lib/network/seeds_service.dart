import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:seeds_system/network/seeds_api_model.dart';

class SeedApiService {
  static Future<void> postSeeds(SeedsApiModel seed) async {
    var url = Uri.parse(
        'https://learning-data-sync-mobile.herokuapp.com/datasync/api/seed');

    try {
      final response = await http.post(url,
          body: json.encode({
            "id": seed.id,
            "name": seed.name,
            "manufacturer": seed.manufacturer,
            "manufacturedAt": seed.manufacturedAt,
            "expiresIn": seed.expiresIn,
            "createdAt": seed.createdAt,
            "userId": seed.userId
          }),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
          });
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<SeedsApiModel>> getRemoteSeeds(String userId) async {
    var url = Uri.parse(
        'https://learning-data-sync-mobile.herokuapp.com/datasync/api/seed/$userId');

    try {
      final response = await http.get(url);
      final list = json.decode(response.body);
      final fetchedApiSeeds = List.generate(
          list.length, (index) => SeedsApiModel.fromJson(list[index]));
      return fetchedApiSeeds;
    } catch (error) {
      rethrow;
    }
  }
}
