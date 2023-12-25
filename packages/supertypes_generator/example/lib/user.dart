import 'package:supertypes/supertypes.dart';

part 'user.supertypes.dart';

const _superTypeUserMapping = SuperType(
  jsonMapping: {
    'createdAt': 'created_at',
    'updatedAt': 'updated_at',
  },
);

@_superTypeUserMapping
typedef $User = ({
  int id,
  String name,
  String email,
  String password,
  DateTime createdAt,
  DateTime updatedAt,
});

@_superTypeUserMapping
typedef $UserWithoutPassword = Omit<$User, ({Omit password})>;

@superTypeWithJson
typedef $CreateUser = Omit<$User, ({Omit id, Omit createdAt, Omit updatedAt})>;

@_superTypeUserMapping
typedef $UserWithTokens = Merge<$UserWithoutPassword, $Tokens>;

@superTypeWithJson
typedef $Tokens = ({String accessToken, String refreshToken});
