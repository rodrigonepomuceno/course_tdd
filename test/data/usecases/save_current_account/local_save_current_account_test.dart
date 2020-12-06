import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:course_tdd/domain/entities/entities.dart';
import 'package:course_tdd/domain/helpers/helpers.dart';
import 'package:course_tdd/data/cache/cache.dart';
import 'package:course_tdd/data/usecases/usecases.dart';

class SaveSecureCacheStorageSpy extends Mock implements SaveSecureCacheStorage {}

void main() {
  LocalSaveCurrentAccount sut;
  SaveSecureCacheStorageSpy saveSecureCacheStorage;
  AccountEntity account;

  void mockError() =>
      when(saveSecureCacheStorage.save(key: anyNamed('key'), value: anyNamed('value'))).thenThrow(Exception());

  setUp(() {
    saveSecureCacheStorage = SaveSecureCacheStorageSpy();
    sut = LocalSaveCurrentAccount(saveSecureCacheStorage: saveSecureCacheStorage);
    account = AccountEntity(token: faker.guid.guid());
  });

  test('Should call SaveSecureCacheStorage with correct values', () async {
    await sut.save(account);

    verify(saveSecureCacheStorage.save(key: 'token', value: account.token));
  });

  test('Should throw UnexpectedError if SaveSecureCacheStorage throws', () async {
    mockError();

    final future = sut.save(account);

    expect(future, throwsA(DomainError.unexpected));
  });
}
