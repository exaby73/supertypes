Supertypes is a library for generating complex records. This library has been heavily inspired by
TypeScript's [Utility Types][ts-utility-types].

# Installation

Add `supertypes` and it's companion generator to your `pubspec.yaml`. The easiest way to do this is to use the command
line:

**For Dart projects:**

```sh
dart pub add supertypes dev:supertypes_generator dev:build_runner
```

**For Flutter projects:**

```sh
flutter pub add supertypes dev:supertypes_generator dev:build_runner
```

To generate the types, run `build_runner`:

**For Dart projects:**

```sh
dart run build_runner build # Build once
dart run build_runner watch # Build continuously
```

**For Flutter projects:**

```sh
flutter pub run build_runner build # Build once
flutter pub run build_runner watch # Build continuously
```

# Usage

Every file containing a supertype must have the following:

**It should start with a `part` directive.**

```dart
import 'package:supertypes/supertypes.dart';

part 'example.supertypes.dart';
```

**It should contain a `typedef` with the name of the supertype, prefixed with `$` for public generated records, or `_$`
for private generated records.**

```dart
// Generates a public record called `Example`
@superType
typedef $Example = ();

// Generates a private record called `_Example`
@superType
typedef _$Example = ();
```

# Index

- [Modifier types](#modifier-types)
  - [Partial](#partial)
  - [Required](#required)
  - [Omit](#omit)
    - [Omitting positional fields](#omitting-positional-fields)
  - [Pick](#pick)
    - [Picking positional fields](#picking-positional-fields)
- [Using Supertypes within another Supertype](#using-supertypes-within-another-supertype)

## Modifier types

Modifier types are types that take one or more types and return a new type.

### Partial

The `Partial` modifier type takes a type and makes all of it's fields optional.

```dart
import 'package:supertypes/supertypes.dart';

part 'person.supertypes.dart';

typedef Person = ({
  String firstName,
  String lastName,
  int age,
});

// We want to make all the field nullable to support partial updates
@superType
typedef $UpdatePerson = Partial<Person>;

// This generates:
typedef UpdatePerson = ({
  String? firstName,
  String? lastName,
  int? age,
});
```

### Required

The `Required` modifier type takes a type and makes all of it's fields required.

```dart
import 'package:supertypes/supertypes.dart';

part 'person.supertypes.dart';

// Let's say we have a person type with `lastName` nullable, 
// and we can't update the type easily. 
// We can instead create a new type with all fields required.
typedef Person = ({
  String firstName,
  String? lastName,
  int age,
});

// We want to make all the field nullable to support partial updates
@superType
typedef $CreatePerson = Required<Person>;

// This generates:
typedef CreatePerson = ({
  String firstName,
  String lastName,
  int age,
});
```

### Omit

The `Omit` modifier type takes a type and a list of fields to omit from the type.

```dart
import 'package:supertypes/supertypes.dart';

part 'person.supertypes.dart';

typedef Person = ({
  String firstName,
  String lastName,
  int age,
});

// We want to remove age from the type
@superType
typedef $PersonWithoutAge = Omit<Person, ({Omit age})>;

// This generates:

/// Generate for [$PersonWithoutAge]
typedef PersonWithoutAge = ({
  String firstName,
  String lastName,
});
```

#### Omitting positional fields

It's possible to also omit a positional field. For example:

```dart
typedef Person = (String name, int age);

// We want to remove the x field from the type
@superType
typedef $Age = Omit<Person, (Omit,)>; // This removes the first positional field

// This removes the second positional field. 
// We use `Pick` as a placeholder for the first positional field.
@superType
typedef $Name = Omit<Person, (Pick, Omit)>; 

// This generates:

/// Generate for [$Age]
typedef Age = (int,);

/// Generate for [$Name]
typedef Name = (String,);
```

### Pick

The `Pick` modifier type takes a type and a list of fields to pick from the type and ignores the rest.

```dart
import 'package:supertypes/supertypes.dart';

part 'person.supertypes.dart';

typedef Person = ({
  String firstName,
  String lastName,
  int age,
});

// We want to remove age from the type
@superType
typedef $PersonWithoutAge = Pick<Person, ({Pick firstName, Pick lastName})>;

// This generates:

/// Generate for [$PersonWithoutAge]
typedef PersonWithoutAge = ({
  String firstName,
  String lastName,
});
```

You can also apply a modifier type to the fields you pick:

```dart
import 'package:supertypes/supertypes.dart';

part 'person.supertypes.dart';

typedef Person = ({
  String? firstName,
  String? lastName,
  int age,
});

// Let's make age nullable and and pick firstName as a required field
@superType
typedef $PersonWithNullableAge = Pick<Person, ({Required firstName, Partial age})>;

// This generates:

/// Generate for [$PersonWithNullableAge]
typedef PersonWithNullableAge = ({
  int? age,
  String firstName,
});
```

#### Picking positional fields

It's possible to also pick a positional field. For example:

```dart
typedef Person = (String name, int age);

// We want to remove the x field from the type
@superType
typedef $Name = Pick<Person, (Pick,)>; // This removes the first positional field

// This removes the second positional field. 
// We use `Pick` as a placeholder for the first positional field.
@superType
typedef $Age = Pick<Person, (Omit, Pick)>; 

// This generates:

/// Generate for [$Name]
typedef Name = (String,);

/// Generate for [$Age]
typedef Age = (int,);
```

# Using Supertypes within another Supertype

Supertypes can be used within other supertypes. This is useful for creating complex types that can be reused.
To use a supertype within another supertype, simply use the original type you prefixed with `$` or `_$`.

```dart
import 'package:supertypes/supertypes.dart';

part 'person.supertypes.dart';

typedef Person = ({
  String firstName,
  String lastName,
  int age,
});

@superType
typedef $CreatePerson = Required<Person>;

@superType
typedef $UpdatePerson = Partial<Person>;

@superType
typedef $PersonOperation = ({
  $CreatePerson create,
  $UpdatePerson update,
});

// This generates:

/// Generate for [$CreatePerson]
typedef CreatePerson = ({
  int age,
  String firstName,
  String lastName,
});

/// Generate for [$UpdatePerson]
typedef UpdatePerson = ({
  int? age,
  String? firstName,
  String? lastName,
});

/// Generate for [$PersonOperation]
typedef PersonOperation = ({
  ({
    int age,
    String firstName,
    String lastName,
  }) create,
  ({
    int? age,
    String? firstName,
    String? lastName,
  }) update,
});
```

# Features:

- More modifier types
  - ✅ `Partial` - Make all fields nullable
  - ✅ `Required` - Make all fields required
  - ✅ `Omit` - Omit fields from a type
  - ✅ `Pick` - Pick fields from a type
  - ✅ `Merge` - Merge two types
  - ✅ `WithRequired` - Make certain fields required
  - ✅ `WithPartial` - Make certain fields optional
  - `Awaited` - Unwrap a `Future` type recursively
- JSON serialization and deserialization for records
  - Generate `fromJson` top level function
  - Generate `toJson` extension method on the record
- Support for using classes in the supertype records by extracting their fields

[ts-utility-types]: https://www.typescriptlang.org/docs/handbook/utility-types.html
