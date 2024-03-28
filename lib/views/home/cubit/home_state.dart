
part of 'home_cubit.dart';

final class HomeState {
  final bool isLoading;
  final Failure? failure;
  final List<Data>? data;
  HomeState({this.isLoading = false, this.failure, this.data});

  HomeState copyWith({
    bool? isLoading,
    Failure? failure,
    List<Data>? data,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
      data: data ?? this.data,
    );
  }
}
