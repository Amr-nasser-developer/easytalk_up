class ProviderGeneralState<T> {
  bool hasData, hasError, waiting;
  T? data;
  String ? error;
  ProviderGeneralState(
      {this.data,
        this.error,
      this.hasData = false,
      this.hasError = false,
      this.waiting = false});
}
