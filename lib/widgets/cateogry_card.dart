
import 'package:e_commerce_platzi/view/filtered_producuts/filteredProducts.dart';
import 'package:e_commerce_platzi/view_model/home_cubit/home_cubit.dart';
import 'package:e_commerce_platzi/view_model/theme_cubit/theme_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/category_model/category_model.dart';

class CategoriesCard extends StatelessWidget {
  final CategoryModel categories;
  const CategoriesCard({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    var isDarkMood = ThemeCubit.get(context).isDark;
    return GestureDetector(
      onTap: (){
        HomeCubit.get(context).getProductsFromCategory(categoryId: categories.id!);
        Navigator.push(context, MaterialPageRoute(builder: (_)=>FilteredProducts()));
      },
      child: Card(
        color: isDarkMood ?Colors.black :Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  categories.image!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    categories.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}