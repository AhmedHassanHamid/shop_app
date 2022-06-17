import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/components/components.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_models.dart';
import 'package:shop_app/models/home_models.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopSuccessFavoritesState)
        {
          if(!state.model.status!)
          {
            showToast(text: state.model.message!, state: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        return ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null
            ? productsBuilder(ShopCubit.get(context).homeModel! , ShopCubit.get(context).categoriesModel, context)
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget productsBuilder(HomeModel model , CategoriesModels categoriesModel , context) => SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data?.banners
                  .map((e) => Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 200,
                initialPage: 0,
                viewportFraction: 1,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Categories',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      )),
                  Container(
                    height: 100,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context ,index) => buildCategorieItem(categoriesModel.data!.data[index]),
                     separatorBuilder: (context ,index) => SizedBox(width:10),
                      itemCount: categoriesModel.data!.data.length),
                  ),
                  Text('New Products',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      )),
                ],
              ),
            ),
                SizedBox(height: 10),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 1.58,
                children: List.generate(
                  model.data!.products.length,
                  (index) => buildGridProduct(model.data!.products[index],context),
                ),
              ),
            )
          ],
        ),
      );

  Widget buildCategorieItem(DataModel model) => Container(
              height: 100,
              width: 100,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Image(
                    image: NetworkImage(
                      model.image!,
                    ),
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.6),
                    width: double.infinity,
                    child: Text(model.name!,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  )
                ],
              ),
            );

  Widget buildGridProduct(ProductsModel model, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: double.infinity,
                  height: 200,
                ),
                if (model.discount != 0)
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.3,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(width: 5),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice.round()}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model.id);
                          print(model.id);
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
      );
}
