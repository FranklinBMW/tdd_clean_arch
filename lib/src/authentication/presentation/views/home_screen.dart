import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tdd_clean_arch/src/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:tdd_clean_arch/src/authentication/presentation/widgets/add_user_dialog.dart';
import 'package:tdd_clean_arch/src/authentication/presentation/widgets/loading_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  void getUsers() {
    context.read<AuthenticationCubit>().getUsers();
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationState>(
      listener: (context, state) {
        if (state is AuthenticationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage),
            ),
          );
        } else if (state is AuthenticationCreatedUser) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'User created successfully',
                style: TextStyle(
                  color: Theme.of(context).primaryColorDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
          getUsers();
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: state is AuthenticationGettingUsers
              ? const LoadingWidget(message: 'Getting Users ...')
              : state is AuthenticationCreatingUser
                  ? const LoadingWidget(message: 'Creating User ...')
                  : state is AuthenticationGetUsers
                      ? Center(
                          child: ListView.builder(
                            itemCount: state.users.length,
                            itemBuilder: (BuildContext context, int index) {
                              final user = state.users[index];
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: ListTile(
                                  title: Text(user.name),
                                  subtitle: Text(user.createdAt),
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(user.avatar),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : state is AuthenticationError
                          ? ErrorWidget.withDetails(
                              error: FlutterError(state.toString()),
                            )
                          : Container(),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              await showAdaptiveDialog(
                context: context,
                builder: (_) => AddUserDialog(
                  nameController: _nameController,
                ),
              );
            },
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: const Icon(Icons.add),
          ),
          floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        );
      },
    );
  }
}
