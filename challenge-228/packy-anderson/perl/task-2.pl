#!/usr/bin/env perl

use v5.38;

use List::Util qw( min );

my @ints = @ARGV; # just accept the list of integers on the command line

my @operations;
my $count = 1;
while ( scalar(@ints) > 0 ) {
  my $min = min @ints;

  # in either case, we're removing the first element from the list
  my $first = shift @ints;

  if ($min == $first) {
    # the first element is the minimum, discard it
    push @operations, "Operation $count: remove element $min: (" . join(',', @ints) . ")";
  }
  else {
    # the first element is NOT the minimum, add it to the end
    push @ints, $first;
    push @operations, "Operation $count: move $first to the end: (" . join(',', @ints) . ")";
  }
  $count++;
}

# produce the output
# let's use @ARGV again, since we modify @ints as we go along
say "Input: \@int = (" . join(', ', @ARGV) . ")";
say "Output: " . scalar(@operations);
say "";
say join "\n", @operations;
