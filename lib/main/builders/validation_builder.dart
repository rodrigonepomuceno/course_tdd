import 'package:course_tdd/validation/protocols/field_validation.dart';
import 'package:course_tdd/validation/validators/validators.dart';

class ValidationBuilder {
  static ValidationBuilder _instance;
  String fieldName;
  List<FieldValidation> validations = [];

  ValidationBuilder._(); //Torna contrutor privado

  static ValidationBuilder field(String fieldName) {
    _instance = ValidationBuilder._();
    _instance.fieldName = fieldName;
    return _instance;
  }

  ValidationBuilder required() {
    validations.add(RequiredFieldValidation(fieldName));
    return this;
  }

  ValidationBuilder email() {
    validations.add(EmailValidation(fieldName));
    return this;
  }

  List<FieldValidation> build() => validations;
}
