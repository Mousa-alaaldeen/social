// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, avoid_print, unused_local_variable, prefer_typing_uninitialized_variables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../style/icon_broken.dart';

Widget deffaultButton({
  double width = double.infinity,
  double height = 50,
  required VoidCallback? function,
  required String? text,
  bool isUpperCase = true,
  // Color textColor = Colors.black,
  double fontSize = 15.0,
  double radius = 7,
  //  required BuildContext context,
}) {
  // Size size = MediaQuery.of(context).size;
  var voidCallback;
  return ClipRRect(
    borderRadius: BorderRadius.circular(15),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaY: 15, sigmaX: 15),
      child: InkWell(
        highlightColor: Colors.amber,
        splashColor: Colors.amber,
        onTap: voidCallback,
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text("$text"),
        ),
      ),
    ),
  );
}

Widget deffaultFormField(
    {required TextEditingController? controller,
    TextInputType? type,
    bool isPassword = false,
    IconData? prefix,
    IconData? suffix,

    //@required var validatee,
    //@required FormFieldValidator? validate,
    final FormFieldValidator<String>? validate,
    VoidCallback? suffixPressed,
    VoidCallback? onTap,
    required BuildContext context,
    bool isClickable = true,
    String? hintText,
    ValueChanged<String>? onFieldSubmitted}) {
  Size size = MediaQuery.of(context).size;
  return Container(
    margin: EdgeInsets.only(left: 30, right: 30, top: 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Colors.white,
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: 15,
          sigmaX: 15,
        ),
        child: Container(
          height: size.width / 8,
          width: size.width / 1.2,
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: size.width / 30),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.05),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextFormField(
            style: TextStyle(color: Colors.deepOrange.withOpacity(.8)),
            cursorColor: Colors.deepOrange,
            controller: controller,
            keyboardType: type,
            obscureText: isPassword,
            decoration: InputDecoration(
              prefixIcon: Icon(prefix),
              border: InputBorder.none,
              hintMaxLines: 1,
              hintText: hintText,
              hintStyle:
                  TextStyle(fontSize: 14, color: Colors.white.withOpacity(.5)),
            ),
            onFieldSubmitted: onFieldSubmitted,
            validator: validate,
            onTap: onTap,
            enabled: isClickable,
          ),
        ),
      ),
    ),
  );
}

Widget deffaultFormField2(
    {required TextEditingController? controller,
    TextInputType? type,
    bool isPassword = false,
    IconData? prefix,
    IconData? suffix,

    //@required var validatee,
    //@required FormFieldValidator? validate,
    final FormFieldValidator<String>? validate,
    VoidCallback? suffixPressed,
    VoidCallback? onTap,
    bool isClickable = true,
    String? hintText,
    ValueChanged<String>? onFieldSubmitted}) {
  return Card(
    margin: EdgeInsets.only(left: 30, right: 30, top: 20),
    elevation: 11,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(40))),
    child: TextFormField(
      validator: validate,
      obscureText: isPassword,
      decoration: InputDecoration(
          suffixIcon: IconButton(
              onPressed: suffixPressed,
              icon: Icon(
                suffix,
                color: Colors.deepOrange,
              )),
          prefixIcon: Icon(
            prefix,
            color: Colors.deepOrange,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.black26,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0)),
    ),
  );
}

Widget defaultFormField3(
    {required TextEditingController? controller,
    TextInputType? type,
    bool isPassword = false,
    IconData? prefix,
    IconData? suffix,

    //@required var validatee,
    //@required FormFieldValidator? validate,
    final FormFieldValidator<String>? validate,
    VoidCallback? suffixPressed,
    VoidCallback? onTap,
    required BuildContext context,
    bool isClickable = true,
    String? label,
    ValueChanged<String>? onFieldSubmitted}) {
  Size size = MediaQuery.of(context).size;
  return Container(
    margin: EdgeInsets.only(left: 30, right: 30, top: 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: 15,
          sigmaX: 15,
        ),
        child: Container(
          height: size.width / 8,
          width: size.width / 1.2,
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: size.width / 30),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.05),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextFormField(
            style: Theme.of(context).textTheme.bodyLarge,
            cursorColor: Colors.deepOrange,
            controller: controller,
            keyboardType: type,
            obscureText: isPassword,
            decoration: InputDecoration(
              prefixIcon: Icon(prefix),
              border: InputBorder.none,
              hintMaxLines: 1,
              hintText: label,
              hintStyle:
                  TextStyle(fontSize: 14, color: Colors.grey.withOpacity(.5)),
            ),
            onFieldSubmitted: onFieldSubmitted,
            validator: validate,
            onTap: onTap,
            enabled: isClickable,
          ),
        ),
      ),
    ),
  );
}

Widget deffaultTextButton(
        {required VoidCallback? onPressed, required String text,context}) =>
    TextButton(
      onPressed: onPressed,
      child: Text(
        text.toUpperCase(),
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );

Widget myDivider() => Container(
      height: 1,
      width: double.infinity,
      color: Colors.grey,
    );
void showToast({
  required String text,
  required ToastState state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: choseToasteColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastState { sUCCESS, eRORR, wORNING }

Color choseToasteColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.sUCCESS:
      color = Colors.green;
      break;
    case ToastState.eRORR:
      color = Colors.red;
      break;
    case ToastState.wORNING:
      color = Colors.amber;
      break;
  }
  return color;
}

// ///
// Widget bulidProductsItem(model, context, {bool isOldPrice = true}) => Container(
//       margin: const EdgeInsets.all(20),
//       height: 120,
//       child: Row(
//         children: [
//           Stack(
//             alignment: AlignmentDirectional.bottomStart,
//             children: [
//               productImage(
//                 imageUrl: "${model.image}",
//               ),
//               /*Image(
//                 image: NetworkImage(
//                   "${model.image}",
//                 ),
//                 width: 120,
//                 height: 120,
//               ),*/
//               if (model.discount != 0 && isOldPrice)
//                 Container(
//                   padding: const EdgeInsets.all(5),
//                   color: Colors.red,
//                   child: const Text(
//                     "Discount",
//                     style: TextStyle(
//                         fontSize: 8,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white),
//                   ),
//                 ),
//             ],
//           ),
//           SizedBox(width: 20),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "${model.name}",
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 14,
//                     height: 1.3,
//                   ),
//                 ),
//                 const Spacer(),
//                 Row(
//                   children: [
//                     Text(
//                       "${model.price}",
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                         height: 1.3,
//                         color: Colors.blue,
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     if (model.discount != 0 && isOldPrice)
//                       Text(
//                         "${model.oldPrice}",
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 12,
//                           height: 1.3,
//                           decoration: TextDecoration.lineThrough,
//                           color: Colors.grey,
//                         ),
//                       ),
//                     const Spacer(),
//                     IconButton(
//                         onPressed: () {
//                           ShopCubit.get(context)
//                               .changeCartData(productId: model.id!);
//                           print(model.id);
//                         },
//                         icon: CircleAvatar(
//                           radius: 15,
//                           backgroundColor:
//                               ShopCubit.get(context).cartProducts[model.id]!
//                                   ? Colors.red
//                                   : Colors.grey,
//                           child: const Icon(
//                             Icons.shopping_cart,
//                             color: Colors.white,
//                           ),
//                         )),
//                     IconButton(
//                         onPressed: () {
//                           ShopCubit.get(context).changeFavoritesData(model.id!);
//                           print(model.id);
//                         },
//                         icon: CircleAvatar(
//                           radius: 15,
//                           backgroundColor:
//                               ShopCubit.get(context).favorits[model.id]!
//                                   ? Colors.blue
//                                   : Colors.grey,
//                           child: const Icon(
//                             Icons.favorite_border,
//                             color: Colors.white,
//                           ),
//                         )),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );

// productImage({
//   required String imageUrl,
//   double height = 120,
//   double width = 120,
// }) =>
//     CachedNetworkImage(
//       height: height,
//       width: width,
//       imageUrl: imageUrl,
//       placeholder: (context, url) => const CircularProgressIndicator(),
//       errorWidget: (context, url, error) => const Icon(Icons.error),
//     );

PreferredSizeWidget myAppBar({
  required String title,
  required BuildContext context,
  List<Widget>? actions,
}) {
  return AppBar(
    title: Text(title),
    titleSpacing: 10,
    actions: actions,
    leading: IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(IconBroken.arrowLeft_2),
    ),
  );
}

Widget myTextField({
  required String labelText,
  required String validateTitle,
  required IconData prefix,
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword = false,
  bool showPass = false,
  Function? changeVisibility,
}) {
  return TextFormField(
    decoration: InputDecoration(
      label: Text(labelText),
      prefixIcon: Icon(prefix),
      border: const OutlineInputBorder(),
      suffixIcon: isPassword
          ? IconButton(
              onPressed: () {
                changeVisibility!();
              },
              icon: showPass
                  ? const Icon(Icons.visibility_outlined)
                  : const Icon(Icons.visibility_off_outlined),
            )
          : null,
    ),
    controller: controller,
    keyboardType: type,
    validator: (value) {
      if (value!.isEmpty) {
        return '$validateTitle must not be empty!';
      }
      return null;
    },
    obscureText: showPass,
  );
}

Widget myButtons({
  required String label,
  required Function onPressed,
  Color buttonColor = Colors.deepOrange,
}) {
  return Container(
    height: 45,
    width: double.infinity,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    decoration: BoxDecoration(
        color: buttonColor, borderRadius: BorderRadius.circular(8)),
    child: MaterialButton(
      onPressed: () {
        onPressed();
      },
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
