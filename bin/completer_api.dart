import 'dart:async';

class AsyncOperation {
  final Completer<String> _completer = new Completer();

  Future<String> doOperation() {
    //_startOperation();
    //To do something
    return _completer.future; // Send future object back to client.
  }

  // Something calls this when the value is ready.
  void _finishOperation(String result) {
    _completer.complete(result);
  }

  // If something goes wrong, call this.
  void _errorHappened(error) {
    _completer.completeError(error);
  }
}
