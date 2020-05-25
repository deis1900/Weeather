import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weeather/blocs/image/image_bloc.dart';
import 'package:weeather/blocs/image/image_state.dart';
import 'package:weeather/model/city_image.dart';

class ImageComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 375,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: BlocBuilder<ImageBloc, ImageState>(
        builder: (context, state) {
          if (state is MainImage) {
            return ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              child: Image.network(
                state.url,
                fit: BoxFit.cover,
                height: 100,
              ),
            );
          }
          else if (state is ImageLoading) {
            return Center(child: CircularProgressIndicator());
          }
          else if (state is ImageLoaded) {
            final CityImage cityPicture = state.image;
            return ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              child: Image.network(
                cityPicture.url,
                fit: BoxFit.cover,
                height: 100,
              ),
            );
          }
          else if (state is ImageError) {
            return Text(
              'Something went wrong!',
              style: TextStyle(color: Colors.red),
            );
          } else {
            throw Exception('Unknown state!');
          }
        },
      ),
    );
  }
}
