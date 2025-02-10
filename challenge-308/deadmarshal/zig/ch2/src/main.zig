const std = @import("std");

fn decodeXor(
    allocator: std.mem.Allocator,
    arr: []const u32,
    first: u32,
) ![]u32 {
    const res = try allocator.alloc(u32, arr.len + 1);
    errdefer allocator.free(res);
    res[0] = first;
    for (0..arr.len) |i| {
        res[i + 1] = res[i] ^ arr[i];
    }
    return res;
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        std.debug.assert(gpa.detectLeaks() == false);
        std.debug.assert(gpa.deinit() == .ok);
    }
    const allocator = gpa.allocator();

    const a1: []const u32 = &.{ 1, 2, 3 };
    const a2: []const u32 = &.{ 6, 2, 7, 3 };

    const res1 = try decodeXor(allocator, a1, 1);
    const res2 = try decodeXor(allocator, a2, 4);

    std.debug.print("{any}\n", .{res1});
    std.debug.print("{any}\n", .{res2});

    defer {
        allocator.free(res1);
        allocator.free(res2);
    }
}
