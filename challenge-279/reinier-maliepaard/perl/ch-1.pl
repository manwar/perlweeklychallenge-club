#!/usr/bin/perl
use strict;
use warnings;

sub sort_letters {

   my @result;

   for (my $i = 0; $i < scalar(@{$_[0]}); $i++) {
        # construct @result by assigning values to elements in a non-sequential order
        $result[$_[1]->[$i]-1] = $_[0]->[$i];

   }

   return(join("", @result, "\n"));
}

# Tests

my @letters;
my @weights;

# Example 1
@letters = ('R', 'E', 'P', 'L');
@weights = (3, 2, 1, 4);
print(sort_letters(\@letters, \@weights), "\n"); # Output: PERL

# Example 2
@letters = ('A', 'U', 'R', 'K');
@weights = (2, 4, 1, 3);
print(sort_letters(\@letters, \@weights), "\n"); # Output: RAKU

# Example 3
@letters = ('O', 'H', 'Y', 'N', 'P', 'T');
@weights = (5, 4, 2, 6, 1, 3);
print(sort_letters(\@letters, \@weights), "\n"); # Output: PYTHON
