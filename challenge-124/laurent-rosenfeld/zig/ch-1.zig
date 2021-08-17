const std = @import("std");
const lines: [5][]const u8 = [_][]const u8{"   QQQQQ", "  Q     Q", " Q       Q", "Q         Q", "     Q"};
const indexes = [_]usize{ 0, 1, 2, 3, 3, 3, 3, 3, 3, 2, 1, 0, 4, 4, 4, 0, 4, 4 };
pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    for (indexes) | idx | {
        try stdout.print("{s}\n", .{lines[idx]});
    }
}
