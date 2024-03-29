import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_test_task/configs/app_strings.dart';
import 'package:webspark_test_task/views/home/cubit/home_cubit.dart';
import 'package:webspark_test_task/views/process/process_screen.dart';
import 'package:webspark_test_task/views/widgets/app_loader.dart';
import 'package:webspark_test_task/views/widgets/custom_appbar.dart';
import 'package:webspark_test_task/views/widgets/custom_elevated_button.dart';
import 'package:webspark_test_task/views/widgets/error_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: Text(AppStrings.homeScreen)),
      body: Center(
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state.data != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProcessScreen(data: state.data!)),
              );
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            AppStrings.setValidApiBaseUrlInOrderToContinue,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.swap_horiz_sharp,
                                  color: Color.fromARGB(255, 137, 137, 137)),
                              const SizedBox(width: 30),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    enabled: !state.isLoading,
                                    decoration: const InputDecoration(
                                      hintText: 'Enter link',
                                      border: UnderlineInputBorder(),
                                    ),
                                    onChanged: (text) => context
                                        .read<HomeCubit>()
                                        .setEndpoint(text),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: CustomElevatedButton(
                              buttonTitle: AppStrings.startCountingProcess,
                              onPressed: state.isLoading
                                  ? null
                                  : () => context
                                      .read<HomeCubit>()
                                      .getDataForProcessing(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                state.isLoading ? const AppLoader() : const SizedBox.shrink(),
                state.failure != null
                    ? ErrorDialog(
                        title: AppStrings.error,
                        message: state.failure!.message,
                        errorCode: state.failure!.code.toString(),
                      )
                    : const SizedBox.shrink(),
              ],
            );
          },
        ),
      ),
    );
  }
}
