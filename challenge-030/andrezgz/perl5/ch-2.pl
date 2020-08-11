#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-030/
# Task #2
# Write a script to print all possible series of 3 positive numbers,
# where in each series at least one of the number is even and
# sum of the three numbers is always 12. For example, 3,4,5.

use strict;
use warnings;

my %groups;

# duplicates are allowed on the same group
# 0 is ommited in all loops (it's not positive)
for my $first ( 1..10 ) {
    for my $second ( 1..10 ) {
        my $third =  12 - $first - $second;   # the sum is 12 (an even number) so one of them is even
        next if $third <= 0;                  # none of them is negative
        my $key = join ' ',                   # create a unique combination ...
                  sort { $a <=> $b }          # by sorting ...
                  $first, $second, $third;    # the 3 numbers.
        print $key.$/ unless $groups{$key}++; # print combination only once.
    }
}


__END__

./ch-2.pl
1 1 10
1 2 9
1 3 8
1 4 7
1 5 6
2 2 8
2 3 7
2 4 6
2 5 5
3 3 6
3 4 5
4 4 4
