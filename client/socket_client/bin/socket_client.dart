import 'dart:io';
import 'dart:typed_data';

void main() async {
  //connect to the socket server
  final socket = await Socket.connect('localhost', 8080);

  //listen responses fomr the server
  socket.listen(

      //handle data from the server
      (Uint8List data) {
    final serverResponse = String.fromCharCodes(data);

    print('Server: $serverResponse');
  },

      //handle error
      onError: (err) {
    print(err);
    socket.destroy();
  },

      //handle server ending connection

      onDone: () {
    print('Sever left.');
    socket.destroy();
  });

  //send some messages to the server
  await sendMessage(socket, 'Knock, knock.');
  await sendMessage(socket, 'Banana');
  await sendMessage(socket, 'Banana');
  await sendMessage(socket, 'Banana');
  await sendMessage(socket, 'Banana');
  await sendMessage(socket, 'Banana');
  await sendMessage(socket, 'Orange');
  await sendMessage(socket, "Orange you glad I didn't say banana again?");
}

Future<void> sendMessage(Socket socket, String message) async {
  //
  print('Client: $message');
  socket.write(message);
  await Future.delayed(Duration(seconds: 2));
}
