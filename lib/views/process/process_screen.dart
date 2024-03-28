import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webspark_test_task/configs/app_strings.dart';
import 'package:webspark_test_task/models/data_for_processing_model.dart';
import 'package:webspark_test_task/views/process/cubit/process_cubit.dart';
import 'package:webspark_test_task/views/result/result_list_screen.dart';
import 'package:webspark_test_task/views/widgets/custom_elevated_button.dart';

class ProcessScreen extends StatefulWidget {
  const ProcessScreen({super.key, required this.data});

  final List<Data> data;

  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  final ProcessCubit processCubit = ProcessCubit();

  @override
  void initState() {
    super.initState();
    processCubit.init(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(AppStrings.processScreen),
      ),
      body: BlocBuilder<ProcessCubit, ProcessState>(
        bloc: processCubit,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                      child: Text(
                        state.isProcessing ? AppStrings.calculation : AppStrings.allCalculationsHasFinished,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        SizedBox(
                          width: 100,
                          height: 100,
                          child:
                              CircularProgressIndicator(value: state.progress),
                        ),
                        Text(
                          '${(state.progress * 100).toStringAsFixed(0)}%',
                          style: const TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    buttonTitle: AppStrings.sendResultsToServer,
                    onPressed: state.isProcessing
                        ? null
                        : () async {
                          final navigator = Navigator.of(context);
                          await processCubit.sendResultsToServer();
                          navigator.push(
                            MaterialPageRoute(
                              builder: (context) => const ResultListScreen(),
                            ),
                          );
                        },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
