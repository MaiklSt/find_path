part of 'process_cubit.dart';

final class ProcessState {
  final bool isProcessing;
  final double progress;

  ProcessState({this.isProcessing = true, this.progress = 0});

  ProcessState copyWith({
    bool? isProcessing,
    double? progress,
  }) {
    return ProcessState(
      isProcessing: isProcessing ?? this.isProcessing,
      progress: progress ?? this.progress,
    );
  }
}