import 'package:flutter/material.dart';
import '../models/cafe_model.dart';

class CafeCard extends StatelessWidget {
  final CafeModel cafe;
  final VoidCallback? onTap;

  const CafeCard({Key? key, required this.cafe, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: ListTile(
          leading: cafe.imageUrl != null
              ? CircleAvatar(
                  backgroundImage: NetworkImage(cafe.imageUrl!),
                )
              : const CircleAvatar(child: Icon(Icons.local_cafe)),
          title: Text(cafe.name),
          subtitle: Text(cafe.address),
        ),
      ),
    );
  }
}
