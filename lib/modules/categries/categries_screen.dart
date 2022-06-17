import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/states.dart';

import '../../layout/cubit/cubit.dart';
import '../../models/categories_models.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return ListView.separated(
            itemBuilder: (context, index) => buildCatItem(ShopCubit.get(context).categoriesModel.data!.data[index]),
            separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                    color: Colors.grey,
                    height: 1,
                  ),
                ),
            itemCount: ShopCubit.get(context).categoriesModel.data!.data.length);
      },
    );
  }

  Widget buildCatItem(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(children: [
          Image(
            image: NetworkImage(model.image!),
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 20,
          ),
          Text(model.name!,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Spacer(),
          Icon(Icons.arrow_forward_ios),
        ]),
      );
}
