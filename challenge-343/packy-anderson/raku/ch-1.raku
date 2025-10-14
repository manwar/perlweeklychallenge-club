#!/usr/bin/env raku
use v6;

sub zeroFriend(@nums) {
  @nums.map({ abs($_) }).min;
}

sub solution(@nums) {
  say 'Input: @nums = (' ~ @nums.join(', ') ~ ')';
  say 'Output: ' ~ zeroFriend(@nums);
}

say "Example 1:";
solution([4, 2, -1, 3, -2]);

say "\nExample 2:";
solution([-5, 5, -3, 3, -1, 1]);

say "\nExample 3:";
solution([7, -3, 0, 2, -8]);

say "\nExample 4:";
solution([-2, -5, -1, -8]);

say "\nExample 5:";
solution([-2, 2, -4, 4, -1, 1]);
