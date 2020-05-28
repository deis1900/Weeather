import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weeather/blocs/image/image_bloc.dart';
import 'package:weeather/blocs/image/image_state.dart';

class ImageComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 379,
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
          } else if (state is ImageLoaded) {
            return CarouselSlider.builder(
              options: CarouselOptions(
                height: 369,
                aspectRatio: 16 / 9,
                viewportFraction: 1.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 4),
                autoPlayAnimationDuration: Duration(milliseconds: 1200),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
              itemCount: state.images.length,
              itemBuilder: (context, itemIndex) => SizedBox(
                height: 369,
                width: 500,
                child: Stack(
                  children: <Widget>[
                    Image(
                      image: NetworkImage(state.images[itemIndex].url),
                      fit: BoxFit.fill,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5.0, top: 5.0),
                      child: Text(
                        'photo by '
                        '${state.images[itemIndex].photographer}'
                        ' on unsplash.',
                        style: TextStyle(
                          backgroundColor: Color.fromARGB(130, 255, 255, 255),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          } else if (state is ImageLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ImageError) {
            return Text(
              'Something went wrong! Check internet connection',
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
