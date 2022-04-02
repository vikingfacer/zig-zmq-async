const std = @import("std");
const zmq = @cImport(
    {@cInclude("zmq.h");}
    );

pub fn main() u8 {
    var context : ?*c_void = zmq.zmq_ctx_new ();
    std.log.info("All your codebase are belong to us.", .{});
    var responder : ?*c_void = zmq.zmq_socket (context, zmq.ZMQ_REP);
    var rc : c_int = zmq.zmq_bind (responder, "tcp://*:5555");

    while (true) {
        var buffer : [10]u8 = undefined;
        _ = zmq.zmq_recv (responder, &buffer, 10, 0);
        std.log.info("Received Hello\n", .{});
        // need zig sleep
        _ = zmq.zmq_send (responder, "World", 5, 0);
    }
    return 0;
}
