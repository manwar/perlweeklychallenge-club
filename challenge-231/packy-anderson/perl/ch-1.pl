#!/usr/bin/env perl
 
use v5.38;

use Lingua::EN::Inflexion qw( verb );
use List::Util qw( min max );

sub array_join {
  return '(' . join(', ', @_) . ')';
}

sub neither_min_nor_max {
  my $min = min @_; # find the minimum value
  my $max = max @_; # find the maximum value

  # grep preserves the order of the array, it just
  # passes along the elements that meet the criteria
  my @neither = grep { $_ != $min && $_ != $max } @_;
  if (@neither) {
    # if we have elements, pass them back in an array reference
    return ($min, $max, \@neither);
  }
  else {
    # otherwise, pass back the requested -1
    return ($min, $max, -1);
  }
}

sub solution {
  my @ints = @_;
  say 'Input: @ints = ' . array_join(@ints);

  my ($min, $max, $neither) = neither_min_nor_max(@ints);

  print 'Output: ';
  if ( ref($neither) eq 'ARRAY' ) {
    # if we were passed back an array reference,
    # print it like an array
    say array_join(@$neither);

    # inflect the verb!
    my $is = @$neither == 1
           ? verb('is')->singular(3)
           : verb('is')->plural(3);

    print "The minimum is $min and maximum is $max "
        . "in the given array. ";
    say "So " . array_join(@$neither)
      . " $is neither min nor max.";
  }
  else {
    # otherwise, print the value unadorned
    say $neither;
  }
}

say "Example 1:";
solution(3, 2, 1, 4);

say "";

say "Example 2:";
solution(3, 1);

say "";

say "Example 3:";
solution(2, 1, 3);