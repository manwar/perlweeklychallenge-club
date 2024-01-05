// Run as: `zig test zig/ch-2.zig`
const std = @import("std");

fn signed_int_or_length(word: []const u8) i64 {
    return std.fmt.parseInt(i64, word, 10)
        catch @as(i64, @intCast(word.len));
}

fn task2(words: []const []const u8) i64 {
    var ret: i64 = std.math.minInt(i64);

    for (words) |word| {
        ret = @max(ret, signed_int_or_length(word));
    }

    return ret;
}

pub fn main() void {}
const expect = std.testing.expect;
test "Task example 1"  { try expect(task2(&[_][]const u8 { "perl", "2", "000", "python", "r4ku" }) ==  6); }
test "Task example 2"  { try expect(task2(&[_][]const u8 { "001", "1", "000", "0001"            }) ==  1); }
test "Max is negative" { try expect(task2(&[_][]const u8 { "-3", "-55", "-987",                 }) == -3); }
