import 'package:flutter/material.dart';
import 'package:news_app_api/modules/web_view/web_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

Widget customFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  Function(String)? onChange,
  Function()? onTap,
  bool isPassword = false,
  required String? Function(String?) validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function()? suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

//////////
Widget myDivider() => Padding(
  padding: const EdgeInsets.all(20.0),
  child:   Container(
    height: 1,
    color: Colors.grey,
  ),
);

////////////
Widget buildArticlesItem(context, article) => InkWell(

  onTap: (){
    navigateTo(
        context,
        WebViewScreen(url: article['url']),
    );
  },

  child:   Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(

          children: [

            Container(

              width: 120,

              height: 120,

              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(10),

                image: DecorationImage(

                  image: NetworkImage('${article['urlToImage']}'),

                  fit: BoxFit.cover,

                ),

              ),

            ),

            SizedBox(

              width: 20,

            ),

            Expanded(

              child: Container(

                height: 120,

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [

                    Expanded(

                      child: Text(

                        '${article['title']}',

                        maxLines: 3,

                        overflow: TextOverflow.ellipsis,

                        style: Theme.of(context).textTheme.bodyText1,

                      ),

                    ),

                    Text(

                      '${article['publishedAt']}',

                      style: TextStyle(

                        color: Colors.grey,

                      ),

                    ),

                  ],

                ),

              ),

            ),

          ],

        ),

      ),
);

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
        builder:(context) => widget,
    ),
);
