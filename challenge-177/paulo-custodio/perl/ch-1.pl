#!/usr/bin/env perl

# Perl Weekly Challenge 177 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-177/

use Modern::Perl;

# https://en.wikipedia.org/wiki/Damm_algorithm

my @table = (
        [qw( 0  3   1   7   5   9   8   6   4   2 )],
        [qw( 7  0   9   2   1   5   4   8   6   3 )],
        [qw( 4  2   0   6   8   7   1   3   5   9 )],
        [qw( 1  7   5   0   9   8   3   4   2   6 )],
        [qw( 6  1   2   3   0   4   5   9   7   8 )],
        [qw( 3  6   7   4   2   0   9   5   8   1 )],
        [qw( 5  8   6   9   7   2   0   1   3   4 )],
        [qw( 8  9   4   5   3   6   2   0   1   7 )],
        [qw( 9  4   3   8   6   1   7   2   0   5 )],
        [qw( 2  5   8   1   4   3   6   7   9   0 )],
);

sub validate {
    my($n) = @_;
    my $digit = 0;
    for (split //, $n) {
        $digit = $table[$digit][$_];
    }
    return $digit==0 ? 1 : 0;
}

@ARGV==1 or die "usage: ch-2.pl number\n";
say validate(shift);
