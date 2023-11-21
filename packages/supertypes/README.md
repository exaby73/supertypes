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

- [Modifier types][#modifier-types]
  - [Partial][#partial]
  - [Required][#required]

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

# Future features:

- [ ] More modifier types
  - [ ] `Omit` - Omit fields from a type
  - [ ] `Pick` - Pick fields from a type
  - [ ] `Awaited` - Unwrap a `Future` type recursively
  - [ ] `WithRequired` - Make certain fields required
  - [ ] `WithPartial` - Make certain fields optional
  - [ ] `Intersect` - Intersect two types
- [ ] JSON serialization and deserialization for records
  - [ ] Generate `fromJson` top level function
  - [ ] Generate `toJson` extension method on the record
- [ ] Support for using classes in the supertype records by extracting their fields

[ts-utility-types]: https://www.typescriptlang.org/docs/handbook/utility-types.html
