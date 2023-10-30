#!/usr/bin/env raku

use v6;

sub loopExistsAt(:@ints, :$start, :%seen) {
  # bail early if we're in a loop we've seen before
  return [] if %seen{$start}:exists;

  my @loop;
  my $i = $start;
  loop (;;) {
    # keep track of the values in the order we visit them
    push @loop, @ints[$i];

    # track where we've already been
    # to avoid double-counting loops
    %seen{$i} = 1;

    # get the next index
    $i = @ints[$i];

    # make sure the index is in bounds
    last unless $i >= 0 && $i < @ints.elems;

    # make sure we haven't seen the index before
    last if %seen{$i}:exists;
  }

  # if the last element points back to
  # the start, it's a loop!
  if (@loop[*-1] == $start) {
    return @loop;
  }
  # otherwise, return an empty list
  return [];
}

sub identifyLoops {
  my @ints = @_;
  my @loops;
  my %seen; # keep track of indices we've seen
            # to avoid duplicating loops
  for 0 .. $@ints.elems - 1 -> $start {
    my @loop = loopExistsAt(
      start => $start,
      ints  => @ints,
      seen  => %seen
    );
    if (@loop) {
      push @loops, @loop;
    }
  }
  return @loops;
}

sub solution {
  my @ints = @_;
  say 'Input: @ints = (' ~ @ints.join(',') ~ ')';
  my @loops = identifyLoops(@ints);
  my $count = @loops.elems;
  say "Output: $count";

  if (@loops) {
    my $loops = $count != 1 ?? 'Loops' !! 'Loop';
    my $are   = $count != 1 ?? 'are'   !! 'is';

    say "\n$loops $are as below:";
    for @loops -> @loop {
      say '[' ~ @loop.join(' ') ~ ']';
    }
  }
}

say "Example 1:";
solution(4,6,3,8,15,0,13,18,7,16,14,19,17,5,11,1,12,2,9,10);

say "\nExample 2:";
solution(0,1,13,7,6,8,10,11,2,14,16,4,12,9,17,5,3,18,15,19);

say "\nExample 3:";
solution(9,8,3,11,5,7,13,19,12,4,14,10,18,2,16,1,0,15,6,17);
