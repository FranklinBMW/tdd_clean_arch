import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_clean_arch/src/authentication/presentation/cubit/authentication_cubit.dart';

class AddUserDialog extends StatelessWidget {
  const AddUserDialog({
    required this.nameController,
    required this.avatarController,
    required this.createdAtController,
    super.key,
  });
  final TextEditingController nameController;
  final TextEditingController avatarController;
  final TextEditingController createdAtController;

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).colorScheme.primary;
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          width: 400.0,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(
                        color: Colors.purpleAccent,
                      )),
                  suffixIcon: Icon(
                    Icons.person,
                    color: iconColor,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: avatarController,
                keyboardType: TextInputType.url,
                textInputAction: TextInputAction.next,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: 'Avatar',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  suffixIcon: Icon(
                    Icons.camera_alt,
                    color: iconColor,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: createdAtController,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.datetime,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: 'Created At',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  suffixIcon: Icon(
                    Icons.calendar_today,
                    color: iconColor,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  foregroundColor: Theme.of(context).colorScheme.onSecondary,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  minimumSize: const Size(double.infinity, 60.0),
                ),
                onPressed: () {
                  final name = nameController.text.trim();
                  const avatar =
                      "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/500.jpg";
                  final createdAt = DateTime.now().toLocal().toString();
                  if (name.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('All fields are required'),
                      ),
                    );
                    return;
                  } else {
                    context.read<AuthenticationCubit>().createUser(
                          name: name,
                          avatar: avatar,
                          createdAt: createdAt,
                        );
                    Navigator.of(context).pop();
                  }
                  ScaffoldMessenger.of(context).clearSnackBars();
                },
                child: const Text('Add User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
