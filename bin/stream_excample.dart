import 'dart:async';
import 'dart:math';

void main(List<String> args) {
  //Giới hạn số lượng dùng take(20)
  khoiTaoStream();
  listenStream();
  // 2 loại Stream Subscription (1 listen) và BroadCast (Nhiều listen)
  subscription_Broadcast();
  controller();
  //Stream Tranformer
}

void khoiTaoStream() {
  //1
  Future<int> _dataFuture = Future.delayed(
    Duration(seconds: 2),
    () => 2,
  );
  Stream _stream1 = Stream.fromFuture(_dataFuture);

  //2 Khoi tao bang Iterable <=> [1,2,3,4,5,6....]
  final _data2 = Iterable.generate(
    4,
    (index) => index * 10,
  );
  Stream _stream2 = Stream.fromIterable(_data2);
  _stream2.listen((event) {
    print(event);
  });

  //3: Khoi tao bang periodic
  Stream _stream3 = Stream.periodic(
    Duration(seconds: 2),
    (value) => value,
  ).take(20);

  //4: khoi tao voi nhieu luong phat
  Stream _steam4 = Stream.fromFutures([]);
}

void listenStream() {
  final _data2 = Iterable.generate(
    4,
    (index) => index * 10,
  );
  Stream _stream2 = Stream.fromIterable(_data2);
  _stream2.listen((event) {
    print(event);
  });
}

void subscription_Broadcast() {
  final _data2 = Iterable.generate(
    4,
    (index) => index * 10,
  );
  Stream _stream2 = Stream.fromIterable(_data2);
  _stream2.listen((event) {
    print(event);
  });
  //StreamSubscription

  StreamSubscription _subscription = _stream2.listen((event) {
    //Todo something
    print(event);
  });

//asBroadcastStream
  Stream _streamBroadcast = Stream.periodic(
    Duration(seconds: 2),
    (value) => value,
  ).take(20).asBroadcastStream();
  _streamBroadcast.listen((event) => print("thread 1: ${event}"));
  _streamBroadcast.listen((event) => print("thread 2: ${event}"));
  // _subscription.cancel();
}

void controller() {
  //
  StreamController<int> controller = StreamController();
  controller.stream.listen((event) {
    //todo something
    print(event);
  });

  //Add data
  controller.sink.add(20);
  controller.sink.add(40);
}

void tranformerStream() {
  //xử lý dữ liệu đầu vào
  final stream = Stream<int>.periodic(
    Duration(seconds: 2),
    (computationCount) => 2,
  );
  stream.transform(StreamTransformer.fromHandlers(
    handleData: (data, sink) => sink.add(data * 10),
  ));
}
