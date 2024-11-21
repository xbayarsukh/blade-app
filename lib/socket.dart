// // ignore_for_file: library_prefixes
// import 'dart:developer';

// import 'package:socket_io_client/socket_io_client.dart' as IO;

// late IO.Socket socket;

// class Socket {
//   Socket() {
//     _connectSocket();
//   }

//   void _connectSocket() {
//     socket = IO.io('http://192.168.1.56:8156', {
//       'transports': ['websocket'],
//       'reconnectionAttempts': 3,
//       'timeout': 10000,
//     });

//     socket.on('connect', (e) {
//       log('Connected: $e');
//     });

//     socket.on('welcome', (e) {
//       log(e.toString());
//     });

//     socket.connect();
//   }

//   // Method to disconnect the socket
//   void disconnect() {
//     socket.disconnect();
//   }
// }
