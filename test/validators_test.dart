import 'package:flutter_test/flutter_test.dart';
import 'package:homigo_care/config/constants.dart';
import 'package:homigo_care/utils/validators.dart';

void main() {
  group('AppConstants', () {
    test('app name is correct', () {
      expect(AppConstants.appName, 'Homigo Care');
    });

    test('app version is set', () {
      expect(AppConstants.appVersion, isNotEmpty);
    });

    test('roles are defined', () {
      expect(AppConstants.rolePatient, 'patient');
      expect(AppConstants.roleDoctor, 'doctor');
      expect(AppConstants.roleNurse, 'nurse');
      expect(AppConstants.rolePharmacy, 'pharmacy');
    });

    test('specializations list is not empty', () {
      expect(AppConstants.specializations, isNotEmpty);
    });
  });

  group('Validators', () {
    test('email validator - valid', () {
      expect(Validators.email('test@example.com'), isNull);
    });

    test('email validator - invalid', () {
      expect(Validators.email('invalid'), isNotNull);
      expect(Validators.email(''), isNotNull);
      expect(Validators.email(null), isNotNull);
    });

    test('password validator - valid', () {
      expect(Validators.password('password123'), isNull);
    });

    test('password validator - too short', () {
      expect(Validators.password('12345'), isNotNull);
    });

    test('password validator - empty', () {
      expect(Validators.password(''), isNotNull);
      expect(Validators.password(null), isNotNull);
    });

    test('confirm password - match', () {
      expect(Validators.confirmPassword('password', 'password'), isNull);
    });

    test('confirm password - no match', () {
      expect(Validators.confirmPassword('password1', 'password'), isNotNull);
    });

    test('name validator - valid', () {
      expect(Validators.name('John'), isNull);
    });

    test('name validator - too short', () {
      expect(Validators.name('J'), isNotNull);
    });

    test('name validator - empty', () {
      expect(Validators.name(''), isNotNull);
      expect(Validators.name(null), isNotNull);
    });

    test('age validator - valid', () {
      expect(Validators.age('25'), isNull);
    });

    test('age validator - invalid', () {
      expect(Validators.age('abc'), isNotNull);
      expect(Validators.age('200'), isNotNull);
    });

    test('phone validator - valid', () {
      expect(Validators.phone('1234567890'), isNull);
    });

    test('phone validator - too short', () {
      expect(Validators.phone('123'), isNotNull);
    });
  });
}
