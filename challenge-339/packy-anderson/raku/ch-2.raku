#!/usr/bin/env raku
use v6;

sub peakPoint(@gain) {
  my $max = 0; # we start at 0
  @gain.reduce({ my $s = $^a + $^b; $max = max($max, $s); $s });
  $max;
}

sub solution(@gain) {
  say 'Input: @gain = (' ~ @gain.join(', ') ~ ')';
  say 'Output: ' ~ peakPoint(@gain);
}

say "Example 1:";
solution([-5, 1, 5, -9, 2]);

say "\nExample 2:";
solution([10, 10, 10, -25]);

say "\nExample 3:";
solution([3, -4, 2, 5, -6, 1]);

say "\nExample 4:";
solution([-1, -2, -3, -4]);

say "\nExample 5:";
solution([-10, 15, 5]);
