#!/usr/bin/env perl
use strict;
use warnings;

use feature 'say';
use List::Util 'sum';

# Task 2: Happy Numbers

# Write a script to find the first 8 Happy Numbers in base 10. For more
# information, please check out Wikipedia.

# Starting with any positive integer, replace the number by the sum of the
# squares of its digits, and repeat the process until the number equals 1
# (where it will stay), or it loops endlessly in a cycle which does not
# include 1.

# Those numbers for which this process end in 1 are happy numbers, while
# those numbers that do not end in 1 are unhappy numbers.

# Example
# 19 is Happy Number in base 10, as shown:

# 19 => 1^2 + 9^2
#    => 1   + 81
#    => 82 => 8^2 + 2^2
#          => 64  + 4
#          => 68 => 6^2 + 8^2
#                => 36  + 64
#                => 100 => 1^2 + 0^2 + 0^2
#                       => 1 + 0 + 0
#                       => 1

sub happy_number {
  my $number = my $start = shift;

  my %seen;
  until ($number == 1) {
    my $new_number = sum map { $_**2 } split //, $number;
    return if $seen{$new_number}++;
    $number = $new_number;
  }

  return 1;
}

my $found = 0;
for (my $i = 0; $found < 8; $i++) {
  if (happy_number($i)) {
    $found++;
    say $i;
  }
}

__END__
use Test::More;

ok happy_number(19), '19 is a happy number';
ok !happy_number(4), '4 is a sad number :(';

done_testing;