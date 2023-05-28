import 'package:isar/isar.dart';
import 'package:isar_example/models/expense.dart';
import 'package:path_provider/path_provider.dart';

///1. Call IsarHelper.instance to get the instance of IsarHelper
///
/// ```dart
///   final isarHelper = IsarHelper.instance;
/// ```
/// 2. Call the init method to initialize Isar
/// ```dart
///   
///   await isarHelper.init();
///  
/// ```
/// 3. Then, you can access Isar directly by 
/// 
/// ```dart
/// 
///  final isar = IsarHelper.instance.isar
/// 
/// ```
/// 
class IsarHelper {
  //singleton
  const IsarHelper._internal();
  static IsarHelper? _isar;
  static Isar? _isarDb;
  Isar get isar => _isarDb!;

  Future<void> init() async {
    if(_isarDb != null) return;
    final path = (await getApplicationDocumentsDirectory()).path;
    _isarDb = await Isar.open([ExpenseSchema], directory: path);
  }
  static IsarHelper get instance => _isar ??= const IsarHelper._internal();
}