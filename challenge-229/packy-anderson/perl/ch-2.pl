#!/usr/bin/env perl

use v5.38;

# function to return unique elements in array
use List::Util qw( uniq );

sub display_array {
  return "(" . join(q{, }, @_) . ")";
}

sub solution {
  my @arrays = @_;
  say "Input: \@array1 = " . display_array( @{ $arrays[0] } );
  say "       \@array2 = " . display_array( @{ $arrays[1] } );
  say "       \@array3 = " . display_array( @{ $arrays[2] } );

  # Return all the elements that are present in at least 2 out
  # of 3 given arrays.  In the sample input, there are arrays 
  # where there elements appear multiple times in a given
  # array, so we want to examine only UNIQUE elements
  my @unique;
  foreach my $arrayref ( @arrays ) {
    push @unique, [ uniq @$arrayref ];
  }

  # now that we have arrays of only unique elements, let's find
  # elements that occur in more than one array using a hash
  my %occurrences;
  foreach my $arrayref ( @unique ) {
    foreach my $element ( @$arrayref ) {
      $occurrences{$element}++;
    }
  }

  say "Output: " . display_array(
    sort # sort the resulting array of elements numerically
    grep {
      # only include elements that were counted more than once
      $occurrences{$_} > 1;
    } keys %occurrences
  );
}

say "Example 1:";
solution(
  [1, 1, 2, 4],
  [2, 4],
  [4]
);

say "";

say "Example 2:";
solution(
  [4, 1],
  [2, 4],
  [1, 2]
);