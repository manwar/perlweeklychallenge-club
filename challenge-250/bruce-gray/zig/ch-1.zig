// Run as: `zig test zig/ch-1.zig`
const std = @import("std");

fn task1(ns: []const i8) i8 {
    for (ns, 0..) |n, index| {
        if ((index % 10) == n) {
            return @as(i8, @intCast(index));
        }
    }
    return -1;
}


pub fn main() void {}
const expect = std.testing.expect;
test "Task example 1" { try expect(task1(&[_]i8{ 0, 1, 2                            }) ==  0); }
test "Task example 2" { try expect(task1(&[_]i8{ 4, 3, 2, 1                         }) ==  2); }
test "Task example 3" { try expect(task1(&[_]i8{ 1, 2, 3, 4, 5, 6, 7, 8, 9, 0       }) == -1); }
test "Breaker 1"      { try expect(task1(&[_]i8{ 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1 }) == 11); }
