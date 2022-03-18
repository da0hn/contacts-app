import 'package:faker/faker.dart';

String makeNewContact() {
  final faker = Faker();
  final person = faker.person;
  final fullName = '${person.firstName()} ${person.lastName()}';
  return fullName;
}
