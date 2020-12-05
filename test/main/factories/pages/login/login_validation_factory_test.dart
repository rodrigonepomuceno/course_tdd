import 'package:course_tdd/main/factories/factories.dart';
import 'package:course_tdd/validation/validators/validators.dart';
import 'package:test/test.dart';

void main() {
  test('Should return de correct validations', () {
    final validations = makeLoginValidations();
    expect(validations, [
      RequiredFieldValidation('email'),
      EmailValidation('email'),
      RequiredFieldValidation('password'),
    ]);
  });
}
