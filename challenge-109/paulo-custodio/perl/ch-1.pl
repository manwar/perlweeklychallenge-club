#!/usr/bin/env perl

# Challenge 109
#
# TASK #1 - Chowla Numbers
# Submitted by: Mohammad S Anwar
# Write a script to generate first 20 Chowla Numbers, named after,
# Sarvadaman D. S. Chowla, a London born Indian American mathematician.
# It is defined as:
#
# C(n) = sum of divisors of n except 1 and n
# NOTE: Updated the above definition as suggested by Abigail [2021/04/19 18:40].
# Output:
# 0, 0, 0, 2, 0, 5, 0, 6, 3, 7, 0, 15, 0, 9, 8, 14, 0, 20, 0, 21

use Modern::Perl;

first_chowla(shift || 20);

sub first_chowla {
    my($num) = @_;
    for my $i (1..$num) {
        print ", " if $i > 1;
        print chowla($i);
    }
    print "\n";
}

sub chowla {
    my($n) = @_;
    my @terms = grep {$_!=1 && $_!=$n} divisors($n);
    my $sum = 0; $sum += $_ for @terms;
    return $sum;
}

sub divisors {
    my($n) = @_;
    my(@div_low, @div_high);
    for (my $i = 1; $i <= sqrt($n); $i++) {
        if ($n%$i == 0) {
            push @div_low, $i;
            unshift @div_high, $n/$i if $n/$i != $i;
        }
    }
    return (@div_low, @div_high);
}
