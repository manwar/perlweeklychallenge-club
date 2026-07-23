#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( any );

sub hamiltonianCycleMulti($n, $path, $square, %nums) {
  # do we have $n numbers in the path
  if ($n == scalar @$path) {
    # is first+last a square? if it is, we're done!
    my $sum = $path->[0] + $path->[-1];
    # it doesn't sum to a square, ditch the last in path
    pop @$path unless any { $sum == $_ } @$square;
    return;
  }
  for my $s ( @$square ) {
    my $diff = $s - $path->[-1];
    next unless exists $nums{$diff}; # not a num that's waiting

    # it's a possibility, add it to the path
    push @$path, $diff;

    # remove $diff from nums that are waiting
    delete $nums{$diff};

    # call with this proposed path, and all the remaining nums
    hamiltonianCycleMulti($n, $path, $square, %nums);

    # we have a full path, so let's return!
    return if ($n == scalar @$path);

    # put $diff back on the waiting list
    $nums{$diff} = $diff;
  }
  pop @$path; # we didn't find a path, pop off the last & return
  return;
}

sub hamiltonianCycle($n) {
  # precaclulate squares
  my $m = int(sqrt($n + $n-1));
  my @square = map { $_ ** 2 } (2 .. $m);
  my %nums   = map { $_ => $_} (1 .. $n);
  my @path   = ( delete $nums{1} ); # start with 1
  hamiltonianCycleMulti($n, \@path, \@square, %nums);
  return @path;
}

sub solution($n) {
  say qq/Input: \$n = $n/;
  my @path = hamiltonianCycle($n);
  say 'Output: ' . (@path ? join(', ', @path) : '()');
  say "";
  if (! @path) {
    say "No valid circular list of numbers exists.";
  }
  else {
    my $first = $path[0];
    my $last  = shift @path;
    while (my $next = shift @path) {
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
