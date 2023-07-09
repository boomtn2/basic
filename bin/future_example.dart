import 'dart:async';

void main(List<String> arguments) async {
  print(await dataDelay());
  print(dataCompleter());
  print("end");
}

Future<String> dataDelay() {
  return Future.delayed(
    Duration(seconds: 2),
    () => "Data delay 2s",
  );
}

Future<String> dataCompleter() {
  Completer<String> _completer = Completer.sync();
  Future.delayed(
    Duration(seconds: 2),
    () {
      _completer.complete("Done Completer");
    },
  );
  Stream dataStream = Stream.fromFuture(_completer.future);
  dataStream.listen((event) {
    print(event);
  });

  return _completer.future;
}
