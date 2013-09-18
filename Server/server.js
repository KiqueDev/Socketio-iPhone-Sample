var io = require('socket.io').listen(3000);

io.sockets.on('connection', function (socket) {
  socket.send("Connected");
  socket.on('receive', function (data) {
    console.log(data);
    socket.broadcast.emit(data);
    socket.emit("Message Back From Server");
  });
});