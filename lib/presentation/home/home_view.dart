import 'package:flutter/material.dart';
import 'package:heeal/presentation/resources/assets_manager.dart';
import 'package:heeal/presentation/resources/routes_manager.dart';
import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/styles_manager.dart';

class HomeView extends StatelessWidget {
  final String userName = "John"; // For demo, set statically or load dynamically

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Heeal",
          style: getBoldStyle(fontSize: FontSize.s20, color: ColorManager.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(userName),
            const SizedBox(height: 16),
            _buildServiceCard(
              context,
              title: "VR Health Education",
              subtitle: "Interactive",
              trailingIcon: Icons.info_outline_rounded,
              imagePath: ImageAssets.vr_headset,
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, Routes.aiScreen);
              },
              child: _buildServiceCard(
                context,
                title: "AI Disease Detection",
                subtitle: "Smart",
                trailingIcon: Icons.info_outline_rounded,
                imagePath: ImageAssets.ai_detection,
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, Routes.hospitalScreen);
              },
              child: _buildServiceCard(
                context,
                title: "Healthcare Provider",
                subtitle: "Nearby",
                trailingIcon: Icons.search,
                imagePath: ImageAssets.hospital,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String userName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                ImageAssets.scene, // Replace with actual image URL
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Good Morning, $userName!",
                    style: getBoldStyle(fontSize: FontSize.s24, color: ColorManager.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Stay hydrated by drinking at least 8 cups of water.",
                    style: getRegularStyle(fontSize: FontSize.s14, color: ColorManager.white.withOpacity(0.9)),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildServiceCard(
      BuildContext context, {
        required String imagePath, // path to the image asset
        required String title,
        required String subtitle,
        IconData? trailingIcon,
      }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: ColorManager.primaryOpacity70,
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: 48,
            height: 48,
          ),
        ),
        title: Text(
          title,
          style: getSemiBoldStyle(fontSize: FontSize.s16, color: ColorManager.darkGrey),
        ),
        subtitle: Text(
          subtitle,
          style: getLightStyle(fontSize: FontSize.s14, color: ColorManager.grey),
        ),
        trailing: trailingIcon != null
            ? Icon(trailingIcon, color: ColorManager.primary)
            : null,
      ),
    );
  }
}
