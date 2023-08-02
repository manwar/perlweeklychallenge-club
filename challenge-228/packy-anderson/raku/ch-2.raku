#!/usr/bin/env raku

use v6;

my @ints = @*ARGS; # just accept the list of integers on the command line

my @operations;
my $count = 1;
while ( @ints.elems > 0 ) {
  my $min = @ints.min;

  # in either case, we're removing the first element from the list
  my $first = @ints.shift;

  if ($min == $first) {
    # the first element is the minimum, discard it
    push @operations, "Operation $count: remove element $min: (" ~ @ints.join(', ') ~ ")";
  }
  else {
    # the first element is NOT the minimum, add it to the end
    push @ints, $first;
    push @operations, "Operation $count: move $first to the end: (" ~ @ints.join(', ') ~ ")";
  }
  $count++;
}

# produce the output
# let's use @ARGV again, since we modify @ints as we go along
say "Input: \@int = (" ~ @*ARGS.join(', ') ~ ")";
say "Output: " ~ @operations.elems;
say "";
say join "\n", @operations;