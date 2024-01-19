// Mocks generated by Mockito 5.4.4 from annotations
// in shop/test/widget_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:bloc/bloc.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;
import 'package:shop/data/repo/auth/auth_firebase_repository.dart' as _i2;
import 'package:shop/presentation/screen/login/bloc/login_bloc.dart' as _i4;
import 'package:shop/presentation/screen/login/bloc/login_event.dart' as _i6;
import 'package:shop/presentation/screen/login/bloc/login_state.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeAuthRepositoryImpl_0 extends _i1.SmartFake
    implements _i2.AuthFirebaseRepositoryImpl {
  _FakeAuthRepositoryImpl_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeLoginState_1 extends _i1.SmartFake implements _i3.LoginState {
  _FakeLoginState_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [LoginBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginBloc extends _i1.Mock implements _i4.LoginBloc {
  @override
  _i2.AuthFirebaseRepositoryImpl get authRepositoryImpl => (super.noSuchMethod(
        Invocation.getter(#authRepositoryImpl),
        returnValue: _FakeAuthRepositoryImpl_0(
          this,
          Invocation.getter(#authRepositoryImpl),
        ),
        returnValueForMissingStub: _FakeAuthRepositoryImpl_0(
          this,
          Invocation.getter(#authRepositoryImpl),
        ),
      ) as _i2.AuthFirebaseRepositoryImpl);

  @override
  _i3.LoginState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeLoginState_1(
          this,
          Invocation.getter(#state),
        ),
        returnValueForMissingStub: _FakeLoginState_1(
          this,
          Invocation.getter(#state),
        ),
      ) as _i3.LoginState);

  @override
  _i5.Stream<_i3.LoginState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i5.Stream<_i3.LoginState>.empty(),
        returnValueForMissingStub: _i5.Stream<_i3.LoginState>.empty(),
      ) as _i5.Stream<_i3.LoginState>);

  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
        returnValueForMissingStub: false,
      ) as bool);

  @override
  void add(_i6.LoginEvent? event) => super.noSuchMethod(
        Invocation.method(
          #add,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onEvent(_i6.LoginEvent? event) => super.noSuchMethod(
        Invocation.method(
          #onEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void emit(_i3.LoginState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void on<E extends _i6.LoginEvent>(
    _i7.EventHandler<E, _i3.LoginState>? handler, {
    _i7.EventTransformer<E>? transformer,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #on,
          [handler],
          {#transformer: transformer},
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onTransition(
          _i7.Transition<_i6.LoginEvent, _i3.LoginState>? transition) =>
      super.noSuchMethod(
        Invocation.method(
          #onTransition,
          [transition],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i5.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);

  @override
  void onChange(_i7.Change<_i3.LoginState>? change) => super.noSuchMethod(
        Invocation.method(
          #onChange,
          [change],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onError(
    Object? error,
    StackTrace? stackTrace,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
}
