#!/usr/bin/env raku
 
use v6;

sub neither_min_nor_max (*@ints where {$_.all ~~ Int}) {
  my $min = @ints.min; # find the minimum value
  my $max = @ints.max; # find the maximum value

  # grep preserves the order of the array, it just
  # passes along the elements that meet the criteria
  my @neither = @ints.grep({ $_ != $min && $_ != $max });
  if (@neither) {
    # if we have elements, pass them back in an array reference
    return $min, $max, @neither;
  }
  else {
    # otherwise, pass back the requested -1
    return $min, $max, -1;
  }
}

sub solution (*@ints where {$_.all ~~ Int}) {
  say 'Input: @ints = (' ~ @ints.join(', ') ~ ')';

  my ($min, $max, $neither) = neither_min_nor_max(@ints);

  print 'Output: ';
  if ( $neither ~~ Array ) {
    # if we were passed back an array reference,
    # print it like an array
    say '(' ~ $neither.join(', ') ~ ')';

    # inflect the verb!
    my $is = @$neither == 1 ?? 'is' !! 'are';

    print "The minimum is $min and maximum is $max "
        ~ "in the given array. ";
    say "So (" ~ $neither.join(', ')
      ~ ") $is neither min nor max.";
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