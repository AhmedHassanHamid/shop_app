import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/layout/shop_layout.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/on_boarding/cubit/cubit.dart';
import 'package:shop_app/modules/register/register_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/network/local/cache_helper.dart';

class LoginScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status!) {
              print(state.loginModel.data!.token);
              print(state.loginModel.message);

              CacheHelper.saveData(key: 'token', value: state.loginModel.message).then((value) {
                navigateAndFinish(context, ShopLayout());
              });
            } else {
              print(state.loginModel.message);
              showToast(
                text:'${state.loginModel.message}',
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'login now to browes our hot offers',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.text,
                          validator: (String? vlaue) {
                            if (vlaue!.isEmpty) {
                              return 'please enter your email address';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Email Addrss',
                            prefixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: ShopLoginCubit.get(context).isPassword,
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          validator: (String? vlaue) {
                            if (vlaue!.isEmpty) {
                              return 'password is too short';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock_outlined),
                            suffixIcon: IconButton(
                              onPressed: () {
                                ShopLoginCubit.get(context)
                                    .changePasswordVisibility();
                              },
                              icon: Icon(
                                ShopLoginCubit.get(context).suffix,
                              ),
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        // defaultFormField(
                        //   controller: passwordController,
                        //   type: TextInputType.visiblePassword,
                        //   isPassword: true,
                        //   suffixPressed: () {},
                        //   validate: (String value) {
                        //     if (value.isEmpty) {
                        //       return 'password is too short';
                        //     }
                        //     return null;
                        //   },
                        //   prefix: Icons.lock_outlined,
                        //   suffix: Icons.visibility_outlined,
                        //   label: 'Password',
                        // ),
                        SizedBox(height: 30),
                        state is ShopLoginLoadingState
                            ? Center(child: CircularProgressIndicator())
                            : defaultButton(
                                function: () {
                                  if (formKey.currentState!.validate()) {
                                    ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                text: 'login',
                                isUpperCase: true,
                              ),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, RegisterScreen());
                                },
                                child: Text('Regester'.toUpperCase()))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
