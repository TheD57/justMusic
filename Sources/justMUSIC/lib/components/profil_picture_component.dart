import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/Material.dart';
import '../config/routes.dart';
import '../model/User.dart';

class ProfilPictureComponent extends StatelessWidget {
  final User user;
  const ProfilPictureComponent({super.key, required this.user});

  void _openDetail(BuildContext context) {
    print("cc");
    Navigator.of(context).push(routeUser(user));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _openDetail(context);
      },
      child: ClipOval(
        child: SizedBox(
          height: 40,
          width: 40,
          // Image radius
          child: CachedNetworkImage(
            imageUrl: user.pp,
            fadeInDuration: const Duration(milliseconds: 300),
            placeholder: (context, url) => Image(
              image: AssetImage("assets/images/loadingPlaceholder.gif"),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
