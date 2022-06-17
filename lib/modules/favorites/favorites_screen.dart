import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/favorites_model.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return state is! ShopLoadigGetFavoritesState ? Center(child: CircularProgressIndicator()) :ListView.separated(
            itemBuilder: (context, index) => buildFavItem(ShopCubit.get(context).favoritesModel.data!.data![index], context),
            separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Container(
                    color: Colors.grey,
                    height: 1,
                  ),
                ),
            itemCount: ShopCubit.get(context).favoritesModel.data!.data!.length);
      },
    );
  }

  Widget buildFavItem(FavoritesData model, context) => Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 120,
        child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image(
                      image: NetworkImage(model.product!.image!),
                      width: 120,
                      height: 120,
                    ),
                    if (model.product!.discount != 0)
                      Container(
                        color: Colors.red,
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          'DISCOUNT',
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.product!.name!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.3,
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            '${model.product!.price.round()}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(width: 5),
                          if (model.product!.discount != 0)
                            Text(
                              '${model.product!.oldPrice.round()}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          Spacer(),
                          IconButton(
                            onPressed: () {
                              ShopCubit.get(context).changeFavorites(model.product!.id!);
                            },
                            icon: CircleAvatar(
                              radius: 15,
                              backgroundColor: ShopCubit.get(context).favorites[model.id]! ? Colors.blue : Colors.grey,
                              child: Icon(
                              Icons.favorite_border,
                              size: 14,
                              color: Colors.white,
                            ),
                            )
                           
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
      ),
    );
}