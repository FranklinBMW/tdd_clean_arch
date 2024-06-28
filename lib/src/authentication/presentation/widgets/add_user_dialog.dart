import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_clean_arch/src/authentication/presentation/cubit/authentication_cubit.dart';

class AddUserDialog extends StatefulWidget {
  const AddUserDialog({
    required this.nameController,
    super.key,
  });
  final TextEditingController nameController;
  @override
  State<AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {
  final TextEditingController createdAtController = TextEditingController();

  DateTime? selectedDate;

  final FocusNode _focusNode = FocusNode();
  double? _width;
  double _height = 60.0;

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        createdAtController.text = selectedDate.toString();
      });
    }
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus) {
      _animateSize();
    }
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
  }

  void _animateSize() {
    setState(() {
      _width = 300;
      _height = 80.0;
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        _width = View.of(context).devicePixelRatio *
            View.of(context).physicalSize.width /
            3;
        _height = 60.0;
      });

      Future.delayed(const Duration(milliseconds: 1500), () {
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).colorScheme.primary;
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(16.0),
          width: View.of(context).physicalSize.width / 3,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 1500),
                curve: Curves.easeInOut,
                height: _height,
                width: _width ?? View.of(context).physicalSize.width,
                child: TextFormField(
                  focusNode: _focusNode,
                  controller: widget.nameController,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide(
                        color: Colors.purpleAccent,
                      ),
                    ),
                    suffixIcon: Icon(
                      Icons.person,
                      color: iconColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              TextField(
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
                onTap: _selectDate,
                readOnly: true,
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
                  final name = widget.nameController.text.trim();
                  const avatar =
                      "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/500.jpg";
                  final createdAt = createdAtController.text.trim();
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
