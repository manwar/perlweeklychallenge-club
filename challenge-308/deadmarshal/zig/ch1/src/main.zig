const std = @import("std");

fn countCommon(
    allocator: std.mem.Allocator,
    a1: []const []const u8,
    a2: []const []const u8,
) !usize {
    var count: usize = 0;
    var h = std.StringHashMap(u32).init(allocator);
    defer h.deinit();
    for (a1) |s| {
        const entry = try h.getOrPut(s);
        if (entry.found_existing) {
            entry.value_ptr.* += 1;
        } else {
            entry.value_ptr.* = 1;
        }
    }
    for (a2) |s| {
        const entry = try h.getOrPut(s);
        if (entry.found_existing) {
            entry.value_ptr.* += 1;
        } else {
            entry.value_ptr.* = 1;
        }
    }
    var it = h.iterator();
    while (it.next()) |e| {
        if (e.value_ptr.* >= 2) {
            count += 1;
        }
    }
    return count;
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        std.debug.assert(gpa.detectLeaks() == false);
        std.debug.assert(gpa.deinit() == .ok);
    }
    const allocator = gpa.allocator();

    const a1 = [_][]const u8{ "perl", "weekly", "challenge" };
    const a2 = [_][]const u8{ "raku", "weekly", "challenge" };
    const a3 = [_][]const u8{ "perl", "raku", "python" };
    const a4 = [_][]const u8{ "python", "java" };
    const a5 = [_][]const u8{ "guest", "contribution" };
    const a6 = [_][]const u8{ "fun", "weekly", "challenge" };

    std.debug.print("{}\n", .{try countCommon(allocator, &a1, &a2)});
    std.debug.print("{}\n", .{try countCommon(allocator, &a3, &a4)});
    std.debug.print("{}\n", .{try countCommon(allocator, &a5, &a6)});
}
