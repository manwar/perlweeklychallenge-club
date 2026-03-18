#!/usr/bin/env perl

# Perl Weekly Challenge 235 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-235/

use Modern::Perl;

my @ints = @ARGV;
say "(", join(", ", dup_zeros(@ints)), ")";

sub dup_zeros {
    my(@ints) = @_;
    my @result;
    for (@ints) {
        if ($_==0) {
            push @result, 0, 0;
        }
        else {
            push @result, $_;
        }
    }
    return @result[0..$#ints];
}
