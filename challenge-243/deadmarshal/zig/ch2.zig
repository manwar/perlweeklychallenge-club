const std = @import("std");

fn floor_sum(arr:[]const u8) u8 {
  var sum:u8 = 0;
  for(0..arr.len) |i| {
    for(0..arr.len) |j| {
      sum += arr[i] / arr[j];
    }
  }
  return sum;
}

pub fn main() !void {
  const arr1:[3]u8 = .{2,5,9};
  const arr2:[7]u8 = .{7,7,7,7,7,7,7};
  std.debug.print("{}\n",.{floor_sum(&arr1)});
  std.debug.print("{}\n",.{floor_sum(&arr2)});
}

