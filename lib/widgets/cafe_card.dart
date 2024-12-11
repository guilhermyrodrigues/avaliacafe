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
          leading: (cafe.imageUrl.isNotEmpty && isValidUrl(cafe.imageUrl))
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    cafe.imageUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const SizedBox(
                        width: 50,
                        height: 50,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.image_not_supported, size: 50);
                    },
                  ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/placeholder.png',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
          title: Text(cafe.name),
          subtitle: Text(cafe.address),
        ),
      ),
    );
  }

  // Método para validar URL
  bool isValidUrl(String url) {
    final uri = Uri.tryParse(url);
    return uri != null && uri.isAbsolute;
  }
}