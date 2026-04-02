#!/usr/bin/env perl

# Perl Weekly Challenge 171 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-171/

use Modern::Perl;
use List::Util 'sum0';

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

sub proper_divisors {
    my($n) = @_;
    my @div = divisors($n);
    return @div[0..$#div-1];
}

sub is_abundant {
    my($n) = @_;
    return sum0(proper_divisors($n)) > $n;
}

sub abundant_numbers {
    my($N) = @_;
    my @abundant;
    my $n = 1;
    while (@abundant < $N) {
        push @abundant, $n if is_abundant($n);
        $n++;
    }
    return @abundant;
}

@ARGV==1 or die "usage: ch-1.pl n\n";
my $N = shift;
say "(", join(", ", abundant_numbers($N)), ")";
