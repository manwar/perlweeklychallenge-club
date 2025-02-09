const std = @import("std");

fn findAnagrams(
    allocator: std.mem.Allocator,
    arr: [][]const u8,
) !usize {
    var sum: usize = 1;
    var al = std.ArrayList([]u8).init(allocator);
    defer {
        for (al.items) |s| {
            allocator.free(s);
        }
        al.deinit();
    }

    for (arr) |s| {
        try al.append(try allocator.dupe(u8, s));
    }

    for (al.items) |s| {
        std.sort.pdq(u8, s, {}, std.sort.asc(u8));
    }

    for (1..al.items.len) |i| {
        if (std.mem.eql(u8, al.items[i - 1], al.items[i]) == false) {
            sum += 1;
        }
    }

    return sum;
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        std.debug.assert(gpa.detectLeaks() == false);
        std.debug.assert(gpa.deinit() == .ok);
    }
    const allocator = gpa.allocator();

    var arr1 = [_][]const u8{ "acca", "dog", "god", "perl", "repl" };
    var arr2 = [_][]const u8{ "abba", "baba", "aabb", "ab", "ab" };

    std.debug.print("{}\n", .{try findAnagrams(allocator, &arr1)});
    std.debug.print("{}\n", .{try findAnagrams(allocator, &arr2)});
}
