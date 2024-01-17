import 'package:bloc/bloc.dart';
import '../../../../data/repo/auth_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final AuthRepositoryImpl authRepositoryImpl;

  LoginBloc({required this.authRepositoryImpl}) : super(InitialLoginState()) {
    on<LoginEvent>(_loginEventHandler);
  }

  Future<void> _loginEventHandler(LoginEvent event, emit) async {
    emit(LoadingState());
    try {
      await authRepositoryImpl.logIn(event.email, event.password);
      emit(SuccessLoginState());
    } catch (ex) {
      emit(ErrorLoginState(ex.toString()));
    }
  }
}