import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shop/data/repo/auth_repository.dart';
import 'package:shop/presentation/screen/login/bloc/login_bloc.dart';
import 'package:shop/presentation/screen/login/bloc/login_event.dart';
import 'package:shop/presentation/screen/login/bloc/login_state.dart';
import 'unit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AuthRepositoryImpl>()])
void main() {
  final mockRepo = MockAuthRepositoryImpl();
  const email = 'l';
  const password = '123';
  const errorMassage = 'error';

  test('BloC test', () async {
    when(mockRepo.logIn(email, password)).thenAnswer((_) => Future.value(true));

    final bloc = LoginBloc(authRepositoryImpl: mockRepo);

    bloc.add(LoginEvent(email, password));

    await expectLater(
      bloc.stream,
      emitsInOrder([
        isA<LoadingState>(),
        isA<SuccessLoginState>(),
      ]),
    );
  });

  test('Error message test', () async {
    when(mockRepo.logIn(email, password))
        .thenAnswer((_) => Future.error(errorMassage));

    final bloc = LoginBloc(authRepositoryImpl: mockRepo);

    bloc.add(LoginEvent(email, password));

    await expectLater(
      bloc.stream,
      emitsInOrder([
        isA<LoadingState>(),
        isA<ErrorLoginState>().having(
            (state) => state.errorMessage, 'errorMessage', errorMassage),
      ]),
    );
  });
}
