class Resolvable<T> {
  final T? data;
  final dynamic error;
  final bool isLoading;
  final bool isIdle;

  Resolvable(
      {this.data, this.error, required this.isLoading, required this.isIdle});

  factory Resolvable.loading() =>
      Resolvable(isLoading: true, isIdle: false, error: null, data: null);

  factory Resolvable.idle() =>
      Resolvable(isLoading: false, isIdle: true, error: null, data: null);

  factory Resolvable.fromData(T? data) =>
      Resolvable(isLoading: false, isIdle: false, error: null, data: data);

  factory Resolvable.fromError(dynamic error) =>
      Resolvable(isLoading: false, isIdle: false, error: error, data: null);

  factory Resolvable.initial() =>
      Resolvable(error: null, isLoading: false, isIdle: true, data: null);
}
