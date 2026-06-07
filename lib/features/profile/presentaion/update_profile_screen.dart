import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharsa_app/features/profile/presentaion/cubit/profile_cubit.dart';
import 'package:gharsa_app/features/profile/presentaion/cubit/profile_state.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  @override
  void initState() {
    super.initState();

    final state = context.read<ProfileCubit>().state;

    if (state is ProfileSuccess) {
      nameController.text = state.user.name ?? '';
      phoneController.text = state.user.phoneNumber ?? '';
      selectedCityId = state.user.city?.id;
    }
  }

  final nameController = TextEditingController();

  final phoneController = TextEditingController();

  int? selectedCityId;

  String? imagePath;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdated) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Profile Updated')));

          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Edit Profile')),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    final picker = ImagePicker();

                    final image = await picker.pickImage(
                      source: ImageSource.gallery,
                    );

                    if (image != null) {
                      setState(() {
                        imagePath = image.path;
                      });
                    }
                  },
                  child: CircleAvatar(
                    radius: 55,
                    backgroundImage: imagePath != null
                        ? FileImage(File(imagePath!))
                        : null,
                    child: imagePath == null
                        ? const Icon(Icons.camera_alt)
                        : null,
                  ),
                ),

                const SizedBox(height: 24),

                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Full Name'),
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                ),

                const SizedBox(height: 16),

                DropdownButtonFormField<int>(
                  value: selectedCityId,
                  decoration: const InputDecoration(labelText: 'City'),
                  items: const [
                    DropdownMenuItem(value: 1, child: Text('القاهرة')),
                    DropdownMenuItem(value: 2, child: Text('الجيزة')),
                  ],
                  onChanged: (value) {
                    selectedCityId = value;
                  },
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: state is ProfileUpdating
                        ? null
                        : () {
                            context.read<ProfileCubit>().updateProfile(
                              name: nameController.text,
                              phoneNumber: phoneController.text,
                              cityId: selectedCityId,
                              imagePath: imagePath,
                            );
                          },
                    child: state is ProfileUpdating
                        ? const CircularProgressIndicator()
                        : const Text('Save Changes'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
