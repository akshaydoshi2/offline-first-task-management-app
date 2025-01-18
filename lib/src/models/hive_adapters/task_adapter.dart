import 'package:hive/hive.dart';
part 'task_adapter.g.dart';

@HiveType(typeId: 1)
class Task  extends HiveObject{

  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  DateTime? taskDate;

  @HiveField(4)
  bool? hasTime;

  @HiveField(5)
  bool isDone;

  @HiveField(6)
  DateTime createdAt;

  @HiveField(7)
  DateTime? syncDateTime;

  @HiveField(8)
  DateTime updatedAt;

  @HiveField(9)
  bool isDeleted;

  Task(
      {required this.id,
      required this.title,
      required this.description,
      required this.createdAt,
      required this.updatedAt,
      this.taskDate,
      this.hasTime = false,
      this.isDone = false,
      this.isDeleted = false,
      this.syncDateTime});

  Map<String, dynamic> toFirestoreMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'taskDate': taskDate,
      'hasTime': hasTime,
      'isDone': isDone,
      'createdAt': createdAt,
      'syncDateTime': syncDateTime,
      'updatedAt': updatedAt,
      'isDeleted': isDeleted,
    };
  }

  static Task fromFirestoreMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      createdAt: map['createdAt'].toDate(),
      updatedAt: map['updatedAt'].toDate(),
      taskDate: map['taskDate']?.toDate(),
      hasTime: map['hasTime'] ?? false,
      isDone: map['isDone'] ?? false,
      syncDateTime: map['syncDateTime']?.toDate(),
      isDeleted: map['isDeleted'] ?? false,
    );
  }
}