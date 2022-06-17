import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/network/local/cache_helper.dart';

class SettingsScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;

        nameController.text = model.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;
        return ShopCubit.get(context).userModel != null ? Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              defaultFormField(
                  controller: nameController,
                  type: TextInputType.name,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'name must not be empty';
                    }
                    return null;
                  },
                  label: 'Name',
                  prefix: Icons.person),
              SizedBox(
                height: 20,
              ),
              defaultFormField(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'email must not be empty';
                    }
                    return null;
                  },
                  label: 'Email',
                  prefix: Icons.email),
              SizedBox(
                height: 20,
              ),
              defaultFormField(
                  controller: phoneController,
                  type: TextInputType.phone,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'phone must not be empty';
                    }
                    return null;
                  },
                  label: 'Phone',
                  prefix: Icons.phone),
              // TextButton(
              //   onPressed: () {
              //     CacheHelper.removeData(key: 'token').then((value){
              //       if(value){
              //         navigateAndFinish(context, LoginScreen());
              //       }
              //     });
              //   },
              //   child: Text('SIGNOUT'),
              // ),
            ],
          ),
      ) : Center(child: CircularProgressIndicator());
      },
    );
  }
}
