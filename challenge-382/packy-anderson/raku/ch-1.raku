#!/usr/bin/env raku
use v6;

multi hamiltonianCycle($n, @path, %nums is copy, @square) {
  # do we have $n numbers in the path
  if ($n == @path.elems) {
    # is first+last a square? if it is, we're done!
    my $sum = @path[0] + @path[*-1];
    # it doesn't sum to a square, ditch the last in path
    @path.pop unless $sum == @square.any;
    return;
  }
  for @square -> $s {
    my $diff = $s - @path[*-1];
    next unless %nums{$diff}:exists; # not a num that's waiting

    # it's a possibility, add it to the path
    @path.push($diff);

    # remove $diff from nums that are waiting
    %nums{$diff}:delete;

    # call with this proposed path, and all the remaining nums
    hamiltonianCycle($n, @path, %nums, @square);

    # we have a full path, so let's return!
    return if ($n == @path.elems);

    # put $diff back on the waiting list
    %nums{$diff} = $diff;
  }
  @path.pop; # we didn't find a path, pop off the last & return
  return;
}

multi hamiltonianCycle($n) {
  # precaclulate squares
  my $m = sqrt($n + $n-1).Int;
  my @square = (2 .. $m).map({ $_ ** 2 });
  my %nums   = (1 .. $n).map({ $_ => $_});
  my @path   = ( %nums{1}:delete ); # start with 1
  hamiltonianCycle($n, @path, %nums, @square);
  return @path;
}

sub solution($n) {
  say qq/Input: \$n = $n/;
  my @path = hamiltonianCycle($n);
  say 'Output: ' ~ (@path ?? @path.join(', ') !! '()');
  say "";
  if (! @path) {
    say "No valid circular list of numbers exists.";
  }
  else {
    my ($first, $last) = (@path[0], @path.shift);
    while (my $next = @path.shift) {
      printf "%2d + %2d = %2d\n", $last, $next, $last+$next;
      $last = $next;
      unless (@path) {
        printf "%2d + %2d = %2d\n", $last, $first, $last+$first;
      }
    }
  }
}

say "Example 1:";
solution(32);

say "\nExample 2:";
solution(15);

say "\nExample 3:";
solution(34);
