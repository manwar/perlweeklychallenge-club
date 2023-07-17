#!/usr/bin/env perl
use v5.36;

use List::Util qw( min );

sub min_positive {
  my @ints = grep { $_ > 0 } @_; # only consider positive numbers
  return min @ints; # find smallest, undef if empty list
}

sub zero_array {
  my @ints = @_;
  say "Input: \@ints = (" . join(', ', @ints) . ")";
  my @operations;
  while ( my $min = min_positive(@ints) ) {
    my $op_num = scalar(@operations) + 1;
    foreach my $int ( @ints ) {
      $int -= $min if $int > 0;
    }
    push @operations, "operation $op_num: pick $min => (" . join(', ', @ints) . ")";
  }
  say "Output: " . scalar(@operations);
  if (@operations) {
    say "";
    say join "\n", @operations;
  }
}

say "Task 2: Zero Array";
say "\nExample 1";
zero_array(1, 5, 0, 3, 5);

say "\nExample 2";
zero_array(0);

say "\nExample 3";
zero_array(2, 1, 4, 0, 3);
