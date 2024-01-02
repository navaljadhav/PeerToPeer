import 'dart:io';
import 'dart:typed_data';

void main() async {
  // bind the socket server to an address and port
  final server = await ServerSocket.bind('0.0.0.0', 8080);

  // listen for client connection to the server
  server.listen((client) {
    handleConnection(client);
  });
}

void handleConnection(Socket client) {
  print('Connection form'
      '${client.remoteAddress.address}:${client.remotePort}');

  // listen for event from the client
  client.listen((Uint8List data) async {
    await Future.delayed(Duration(seconds: 1));
    final message = String.fromCharCodes(data);
    if (message == 'Knock, Knock.') {
      client.write('who is there?');
    } else if (message.length < 20) {
      client.write('$message who?');
    } else {
      client.write('Very funny');
      client.close();
    }
  },

      //handle error
      onError: (err) {
    print(err);
    client.close();
  },
      // handle the client closing connection
      onDone: () {
    print('Client left');
    client.close();
  });
}
