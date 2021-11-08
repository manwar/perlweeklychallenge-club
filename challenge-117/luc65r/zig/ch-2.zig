const std = @import("std");
const Allocator = std.mem.Allocator;

const stdout = std.io.getStdOut().writer();
var bufferedStdout = std.io.bufferedWriter(stdout);
const bufout = bufferedStdout.writer();

const Move = enum {
    horizontal,
    left,
    right,

    fn toChar(self: Move) u8 {
        return switch (self) {
            Move.horizontal => 'H',
            Move.left => 'L',
            Move.right => 'R',
        };
    }
};

const Position = struct {
    y: u32,
    x: u32,

    fn isBottomRight(self: Position) bool {
        return self.y == 0 and self.x == 0;
    }

    fn move(self: Position, m: Move) ?Position {
        return switch (m) {
            Move.horizontal => .{
                .y = self.y,
                .x = if (self.x > 0) self.x - 1 else return null,
            },
            Move.left => .{
                .y = if (self.y > 0) self.y - 1 else return null,
                .x = self.x + 1,
            },
            Move.right => .{
                .y = if (self.y > 0) self.y - 1 else return null,
                .x = self.x,
            },
        };
    }

    fn printDirs(self: Position, dirs: []u8, depth: u32) anyerror!void {
        if (self.isBottomRight()) {
            try bufout.print("{s}\n", .{dirs[0..depth]});
            return;
        }

        for ([_]Move{ Move.horizontal, Move.left, Move.right }) |m| {
            const pos = self.move(m) orelse continue;
            dirs[depth] = m.toChar();
            try pos.printDirs(dirs, depth + 1);
        }
    }
};

pub fn main() !void {
    const argv = std.os.argv;
    if (argv.len != 2)
        return error.InvalidArguments;

    const size = try std.fmt.parseInt(u32, std.mem.span(argv[1]), 10);

    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = &arena.allocator;

    const position = Position{ .y = size, .x = 0 };

    var dirs = try allocator.alloc(u8, 2 * size);
    try position.printDirs(dirs, 0);
    try bufferedStdout.flush();
}
