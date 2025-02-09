const std = @import("std");

fn checkOrder(
    comptime T: type,
    allocator: std.mem.Allocator,
    arr: []T,
) !std.ArrayList(usize) {
    var ret = std.ArrayList(usize).init(allocator);
    errdefer ret.deinit();
    const sorted = try allocator.alloc(u8, arr.len);
    defer allocator.free(sorted);

    std.mem.copyForwards(T, sorted, arr);
    std.mem.sort(T, sorted, {}, std.sort.asc(T));

    for (sorted, 0..) |_, i| {
        if (sorted[i] != arr[i]) {
            try ret.append(i);
        }
    }

    return ret;
}

fn printArrayList(
    comptime T: type,
    al: std.ArrayList(T),
) void {
    for (al.items) |e| {
        std.debug.print("{} ", .{e});
    }
    std.debug.print("{s}", .{"\n"});
}

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer {
        std.debug.assert(gpa.detectLeaks() == false);
        std.debug.assert(gpa.deinit() == .ok);
    }
    const allocator = gpa.allocator();

    var arr1 = [_]u8{ 5, 2, 4, 3, 1 };
    var arr2 = [_]u8{ 1, 2, 1, 1, 3 };
    var arr3 = [_]u8{ 3, 1, 3, 2, 3 };

    const al1 = try checkOrder(u8, allocator, &arr1);
    const al2 = try checkOrder(u8, allocator, &arr2);
    const al3 = try checkOrder(u8, allocator, &arr3);

    defer {
        al1.deinit();
        al2.deinit();
        al3.deinit();
    }

    printArrayList(usize, al1);
    printArrayList(usize, al2);
    printArrayList(usize, al3);
}
