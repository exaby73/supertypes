// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: non_constant_identifier_names, avoid_dynamic_calls

part of 'note.dart';

// **************************************************************************
// SuperTypesGenerator
// **************************************************************************

/// Generate for [$Foo]
typedef Foo = ({
  String foo,
});

Foo FooFromJson(Map<String, dynamic> json) {
  return (foo: json['foo'] as String,);
}

extension FooJson on Foo {
  Map<String, dynamic> toJson() {
    return {
      'foo': foo,
    };
  }
}

/// Generate for [$Bar]
typedef Bar = ({
  int bar,
  ({
    String foo,
  }) foo,
});

Bar BarFromJson(Map<String, dynamic> json) {
  return (
    bar: json['bar'] as int,
    foo: (foo: json['foo'] as String,),
  );
}

extension BarJson on Bar {
  Map<String, dynamic> toJson() {
    return {
      'bar': bar,
      'foo': foo.toJson(),
    };
  }
}

/// Generate for [$Note]
typedef Note = ({
  String content,
  DateTime createdAt,
  int id,
  List<({int bar, ({String foo}) foo})> statuses,
  String title,
});

Note NoteFromJson(Map<String, dynamic> json) {
  return (
    content: json['content'] as String,
    createdAt: DateTime.parse(json['createdAt'] as String),
    id: json['id'] as int,
    statuses: (json['statuses'] as List)
        .map(
          (e) => (
            bar: json['bar'] as int,
            foo: (foo: json['foo'] as String,),
          ),
        )
        .toList(),
    title: json['title'] as String,
  );
}

extension NoteJson on Note {
  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'createdAt': createdAt.toIso8601String(),
      'id': id,
      'statuses': statuses,
      'title': title,
    };
  }
}

/// Generate for [$NewNote]
typedef NewNote = ({
  String content,
  String title,
});

NewNote NewNoteFromJson(Map<String, dynamic> json) {
  return (
    content: json['content'] as String,
    title: json['title'] as String,
  );
}

extension NewNoteJson on NewNote {
  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'title': title,
    };
  }
}

/// Generate for [$UpdateNote]
typedef UpdateNote = ({
  String? content,
  int id,
  List<({int bar, ({String foo}) foo})>? statuses,
  String? title,
});

UpdateNote UpdateNoteFromJson(Map<String, dynamic> json) {
  return (
    content: json['content'] as String?,
    id: json['id'] as int,
    statuses: json['statuses'] == null
        ? null
        : (json['statuses'] as List)
            .map(
              (e) => (
                bar: json['bar'] as int,
                foo: (foo: json['foo'] as String,),
              ),
            )
            .toList(),
    title: json['title'] as String?,
  );
}

extension UpdateNoteJson on UpdateNote {
  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'id': id,
      'statuses': statuses,
      'title': title,
    };
  }
}
