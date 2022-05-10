import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';

class ImageView extends StatelessWidget {
  final ImageProvider imageProvider;
  final BoxFit? fit;
  final bool isCircular;
  final VoidCallback? onTap;
  final String? accessibilityText;
  final double? imageSize;

  const ImageView({
    Key? key,
    required this.imageProvider,
    this.fit,
    this.isCircular = false,
    this.onTap,
    this.accessibilityText,
    this.imageSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageView = Semantics(
      label: accessibilityText,
      child: ExcludeSemantics(
        child: GestureDetector(
          onTap: onTap,
          excludeFromSemantics: true,
          child: OctoImage(
            image: imageProvider,
            fit: fit,
            imageBuilder:
                isCircular ? OctoImageTransformer.circleAvatar() : null,
            placeholderBuilder: (context) => ImageViewPlaceholder(
              isCircular: isCircular,
            ),
            errorBuilder: (context, error, stackTrace) => ImageViewPlaceholder(
              isCircular: isCircular,
            ),
          ),
        ),
      ),
    );
    if (imageSize != null) {
      return SizedBox(
        width: imageSize,
        height: imageSize,
        child: imageView,
      );
    }
    return imageView;
  }
}

class ImageViewPlaceholder extends StatelessWidget {
  final bool isCircular;
  final Icon? placeholderIcon;

  const ImageViewPlaceholder({
    Key? key,
    this.isCircular = false,
    this.placeholderIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icon = placeholderIcon;
    final placeholder = Container(
      decoration: const BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: icon != null
          ? const Icon(
              Icons.image,
              color: Colors.white,
            )
          : const SizedBox(),
    );

    if (isCircular) {
      return Center(
        child: AspectRatio(
          aspectRatio: 1.0,
          child: ClipOval(
            child: placeholder,
          ),
        ),
      );
    }

    return placeholder;
  }
}
