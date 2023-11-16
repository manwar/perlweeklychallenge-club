const std = @import("std");

fn reverse_pairs(arr:[]const u8) u8 {
  var count:u8 = 0;
  for(0..arr.len-1) |i| {
    for(i+1..arr.len) |j| {
      if(arr[i] > (2 * arr[j])) count += 1;
    }
  }
  return count;
}

pub fn main() !void {
  const arr1:[5]u8 = .{1,3,2,3,1};
  const arr2:[5]u8 = .{2,4,3,5,1};
  std.debug.print("{}\n",.{reverse_pairs(&arr1)});
  std.debug.print("{}\n",.{reverse_pairs(&arr2)});
}

