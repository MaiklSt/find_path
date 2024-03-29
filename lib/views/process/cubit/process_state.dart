part of 'process_cubit.dart';

final class ProcessState {
  final bool isProcessing;
  final double progress;
  final bool isSending;
  final Failure? failure;
  final bool isFailure;

  ProcessState({this.isProcessing = true, this.progress = 0, this.isSending = false, this.failure, this.isFailure = false});

  ProcessState copyWith({
    bool? isProcessing,
    double? progress,
    bool? isSending,
    Failure? failure,
    bool? isFailure,
  }) {
    return ProcessState(
      isProcessing: isProcessing ?? this.isProcessing,
      progress: progress ?? this.progress,
      isSending: isSending ?? this.isSending,
      failure: failure ?? this.failure,
      isFailure: isFailure ?? this.isFailure,
    );
  }
}