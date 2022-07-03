import 'package:gsheets/gsheets.dart';
import 'package:flutter_application_1/model/user.dart';

class UserSheetsApi {
  static const _credentials = r'''
ADD CREDENTIALS HERE
''';
  static final _spreadsheetId = 'ADD SPREADSHEET ID HERE';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet;

  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _userSheet = await _getWorkSheet(spreadsheet, title: 'Students');
    } catch (e) {
      print('Init Error : $e');
    }
  }

  static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    return spreadsheet.worksheetByTitle(title)!;
  }

  static Future<User?> getByRno(String Rno) async {
    if (_userSheet == null) return null;
    final json = await _userSheet!.values.map.rowByKey(Rno, fromColumn: 1);
    return json == null ? null : User.fromJson(json);
  }
}
