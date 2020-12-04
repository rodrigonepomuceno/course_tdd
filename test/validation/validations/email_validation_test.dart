import 'package:course_tdd/validation/validations/validations.dart';
import 'package:test/test.dart';

void main() {
  EmailValidation sut;

  setUp(() {
    sut = EmailValidation('any_field');
  });

  test('Shoul return null if email is empty', () {
    expect(sut.validate(''), null);
  });

  test('Shoul return null if email is null', () {
    expect(sut.validate(null), null);
  });

  test('Shoul return null if email is valid', () {
    expect(sut.validate('email@email.com'), null);
  });

  test('Shoul return error if email is invalid', () {
    expect(sut.validate('email@email'), 'Campo inválido');
  });
}
