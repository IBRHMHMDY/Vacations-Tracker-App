import 'package:drift/drift.dart';

@DataClassName('SettingModel')
class SettingsTable extends Table {
  IntColumn get id => integer()();
  TextColumn get employeeName => text()();
  TextColumn get jobTitle => text()();
  IntColumn get totalRegularLeaves => integer()();
  IntColumn get totalCasualLeaves => integer()();
  IntColumn get totalSickLeaves => integer().withDefault(const Constant(0))();
  
  @override
  Set<Column> get primaryKey => {id};
}