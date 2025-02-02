import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps/colors.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatelessWidget {
  final List<XFile> selectedMedia;
  final Function() onPickGalleryImage;
  final Function(int) onRemoveImage;

  const ImageInput({
    super.key,
    required this.selectedMedia,
    required this.onPickGalleryImage,
    required this.onRemoveImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.backgroundSecondary),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            selectedMedia.isEmpty
                ? _buildEmptyState(context)
                : SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: selectedMedia.length +
                          (selectedMedia.length < 5 ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < selectedMedia.length) {
                          return _buildImageItem(
                            File(selectedMedia[index].path),
                            index,
                          );
                        } else {
                          return _buildAddButton(context);
                        }
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return InkWell(
      onTap: onPickGalleryImage,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.my_library_add_outlined,
            size: 36,
            color: AppColors.textPrimary,
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Text(
              'Você pode adicionar até 5 imagens ou vídeos',
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageItem(File imageFile, int index) {
    return Stack(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.file(
            imageFile,
            height: 160,
            width: 150,
            fit: BoxFit.cover,
          ),
        ),
      ),
      Positioned(
          top: 4,
          right: 10,
          child: InkWell(
              onTap: () => onRemoveImage(index),
              child: Container(
                  decoration: const BoxDecoration(
                    color: AppColors.textSecondary,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(2.0),
                  child: const Icon(
                    Icons.close,
                    size: 12,
                    color: Colors.white,
                  ))))
    ]);
  }

  Widget _buildAddButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: InkWell(
        onTap: onPickGalleryImage,
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: AppColors.backgroundPrimary,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Center(
            child: Icon(
              Icons.add,
              size: 40,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
