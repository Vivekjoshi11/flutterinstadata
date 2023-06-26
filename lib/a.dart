// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
// import 'dart:html';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:instadata/secrets.dart';

Future<String> getLongLivedToken(String shortLivedToken) async {
  final response = await http.get(
    Uri.parse('https://graph.instagram.com/access_token'
        '?grant_type=ig_exchange_token'
        '&client_secret=$kAppSecret'
        '&access_token=$shortLivedToken'),
  );

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    return json['access_token'];
  } else {
    throw Exception('Failed to exchange access token');
  }
}
Future<Map<String, dynamic>> getUserProfile(String accessToken) async {
  final response = await http.get(
    Uri.parse('https://graph.instagram.com/me'
        '?fields=id,username,media_count'
        '&access_token=$accessToken'),
  );

  if (response.statusCode == 200) {
    final json = jsonDecode(response.body);
    return json;
  } else {
    throw Exception('Failed to fetch user profile');
  }
 }
 
// FutureBuilder(
//   future: getLongLivedToken('YOUR_SHORT_LIVED_TOKEN'),
//   builder: (context, snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//       return const CircularProgressIndicator();
//     } else if (snapshot.hasError) {
//       return Text('Error: ${snapshot.error}');
//     } else {
//       final longLivedToken = snapshot.data;
//       return FutureBuilder(
//         future: getUserProfile(longLivedToken),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const CircularProgressIndicator();
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else {
//             final profileData = snapshot.data;
//             return Column(
//               children: [
//                 Text('Username: ${profileData['username']}'),
//                 Text('Media Count: ${profileData['media_count']}'),
//               ],
//             );
//           }
//         },
//       );
//     }
//   },
// );
