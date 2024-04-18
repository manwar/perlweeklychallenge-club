#!/usr/bin/perl
use strict;
use warnings;
use Statistics::Frequency;

sub gt33 {

  my @result;

# create a new Statistics::Frequency object.
  my $f = Statistics::Frequency->new(@_);
# return the frequencies as a hash, the elements as the keys and the frequencies as the values.
  my %freq_int = $f->frequencies;

  foreach my $k (sort(keys(%freq_int))) {

    if(($freq_int{$k}/scalar(@_)) > 0.33) {
      push(@result, $k);
    }

  }
# print smallest, i.e. the first array item
  print("Result: $result[0]\n");
}

# TESTS

# Example 1
my @ints_1 = (1, 2, 3, 3, 3, 3, 4, 2);
gt33(@ints_1); # 3

# Example 2
my @ints_2 = (1, 2, 3);
gt33(@ints_2); # 1

# Example 3
my @ints_3 = (1, 1);
gt33(@ints_3); # 1
