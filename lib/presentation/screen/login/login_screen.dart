import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop/presentation/screen/login/bloc/login_bloc.dart';
import 'package:shop/presentation/screen/login/bloc/login_event.dart';
import 'package:shop/presentation/screen/singup_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../dashboard_of_fragments.dart';
import 'bloc/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late LoginBloc loginBloc;
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isObscure = true.obs;

  @override
  void didChangeDependencies() {
    loginBloc = BlocProvider.of<LoginBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(builder: (context, cons) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: cons.maxHeight,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // login screen header
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 285,
                  child: Image.asset("images/shop.jpg"),
                ),

                // login screen sign-in form
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.all(Radius.circular(60)),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, -3),
                          ),
                        ]),
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                        child: BlocConsumer(
                          bloc: loginBloc,
                          builder: (context, LoginState state) {
                            if (state is LoadingState) {
                              return const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.black),
                              );
                            }
                            return loginForm(state);
                          },
                          listener: (context, LoginState state) {
                            if (state is SuccessLoginState) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const DashboardOfFragments(),
                                ),
                              );
                            }
                          },
                        )),
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget loginForm(LoginState state) {
    return Column(
      children: [
        if (state is ErrorLoginState) ...[
          Text(state.errorMessage),
          const SizedBox(
            height: 24,
          ),
        ],
        //email/password/login-btn
        Form(
          key: formKey,
          child: Column(
            children: [
              //email
              TextFormField(
                key: const Key('email_field'),
                controller: emailController,
                validator: (val) =>
                    val == "" ? "Please write your email" : null,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                  hintText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.white60,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.white60,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.white60,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Colors.white60,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 6,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),

              const SizedBox(
                height: 18,
              ),
              //password
              Obx(() => TextFormField(
                    key: const Key('password_field'),
                    controller: passwordController,
                    obscureText: isObscure.value,
                    validator: (val) =>
                        val == "" ? "Please write your password" : null,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.vpn_key_sharp,
                        color: Colors.black,
                      ),
                      suffixIcon: Obx(
                        () => GestureDetector(
                          onTap: () {
                            isObscure.value = !isObscure.value;
                          },
                          child: Icon(
                            isObscure.value
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      hintText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.white60,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.white60,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.white60,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: Colors.white60,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  )),

              const SizedBox(
                height: 18,
              ),

              Material(
                color: Colors.black,
                borderRadius: BorderRadius.circular(30),
                child: InkWell(
                  key: const Key('login_btn'),
                  onTap: () async {
                    loginBloc.add(LoginEvent(emailController.text.trim(),
                        passwordController.text.trim()));
                  },
                  borderRadius: BorderRadius.circular(30),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 28),
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(
          height: 8,
        ),
        //don't have account
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Don't have an account yet?",
              style:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
            ),
            TextButton(
              onPressed: () {
                Get.to(const SignUpScreen());
              },
              child: const Text('Sign up', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),

        const Text(
          'Or',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),

        //admin
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Are you an admin?",
              style:
                  TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Click here', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ],
    );
  }
}
