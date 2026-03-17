#!/usr/bin/env perl

# Perl Weekly Challenge 333 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-333/

use Modern::Perl;

@ARGV or die "usage: $0 nums...\n";
say join ", ", dup_zeros(@ARGV);

sub dup_zeros {
    my(@nums) = @_;
    my @out;
    for (@nums) {
        if ($_) {
            push @out, $_;
        }
        else {
            push @out, 0, 0;
        }
        last if @out >= @nums;
    }
    pop @out if @out > @nums;
    return @out;
}
