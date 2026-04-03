#!/usr/bin/env perl

# Perl Weekly Challenge 174 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-174/

use Modern::Perl;
use List::Util 'sum';

sub is_disarium {
    my($n) = @_;
    my @digits = split //, $n;
    for my $i (1..@digits) {
        $digits[$i-1] = $digits[$i-1] ** $i;
    }
    return sum(@digits) == $n;
}

sub disarium_numbers {
    my($N) = @_;
    my $n = 1;
    my @result;
    while (@result < $N) {
        push @result, $n if is_disarium($n);
        $n++;
    }
    return @result;
}

@ARGV==1 or die "usage: ch-1.pl n\n";
say "(", join(", ", disarium_numbers(shift)), ")";
