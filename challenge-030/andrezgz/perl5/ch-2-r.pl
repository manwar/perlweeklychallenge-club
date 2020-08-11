#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-030/
# Task #2
# Write a script to print all possible series of 3 positive numbers,
# where in each series at least one of the number is even and
# sum of the three numbers is always 12. For example, 3,4,5.

use strict;
use warnings;

use List::Util qw(sum);

series();

sub series {
    our %groups;
    if (@_ == 3) {
        my $key = join ' ', sort { $a <=> $b } @_;
        print $key.$/ if sum(@_) == 12 && !$groups{$key}++;
        return;
    }

    series(@_,$_) for ( 1..10 );

    return;
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
