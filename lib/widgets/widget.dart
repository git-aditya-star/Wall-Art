import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/views/image_view.dart';
import 'package:wallpaper_app/views/search.dart';

Widget brandName() {
  return RichText(
    text: TextSpan(
      text: '',
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
      children: <TextSpan>[
        TextSpan(text: 'Wall', style: TextStyle(color: Colors.black)),
        TextSpan(
            text: 'Art',
            style: TextStyle(
              color: Colors.blue,
            )),
      ],
    ),
  );
}

Widget WallpapersList({List<WallpaperModel> wallpapers, context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      physics: ClampingScrollPhysics(),
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers.map((wallpaper) {
        return GridTile(
            child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ImageView(imgUrl: wallpaper.src.original)));
          },
          child: Hero(
            tag: wallpaper.src.portrait,
            child: Container(
                child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                wallpaper.src.portrait,
                fit: BoxFit.cover,
              ),
            )),
          ),
        ));
      }).toList(),
    ),
  );
}

class SlidingAppBar extends StatelessWidget {
  const SlidingAppBar({
    Key key,
    @required this.appBarImages,
  }) : super(key: key);

  final List appBarImages;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 150,
      floating: false,
      snap: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: brandName(),
        centerTitle: true,
        background: Swiper(
          itemCount: appBarImages.length,
          itemBuilder: (context, index) => Image.asset(
            appBarImages[index],
            fit: BoxFit.cover,
          ),
          autoplay: true,
        ),
      ),
    );
  }
}
