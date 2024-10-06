#!/usr/bin/env perl

# Challenge 175
#
# Task 2: Perfect Totient Numbers
# Submitted by: Mohammad S Anwar
#
# Write a script to generate first 20 Perfect Totient Numbers. Please checkout
# wikipedia page for more informations.
#
# Output
#
# 3, 9, 15, 27, 39, 81, 111, 183, 243, 255, 327, 363, 471, 729,
# 2187, 2199, 3063, 4359, 4375, 5571

use Modern::Perl;

sub gcd {
    my($a, $b) = @_;
    if ($a == 0) {
        return $b;
    }
    else {
        return gcd($b % $a, $a);
    }
}

sub totient {
    my($n) = @_;
    my $count = 0;
    for my $i (1..$n) {
        $count++ if gcd($n, $i) == 1;
    }
    return $count;
}

sub is_perfect_totient {
    my($n) = @_;
    my $sum = 0;
    my $tot = $n;
    while ($tot != 1) {
        $tot = totient($tot);
        $sum += $tot;
    }
    return $sum == $n;
}

sub perfect_totients {
    my($N) = @_;
    my @result;
    my $n = 1;
    while (@result < $N) {
        push @result, $n if is_perfect_totient($n);
        $n++;
    }
    return @result;
}

@ARGV==1 or die "usage: ch-2.pl N\n";
my $N = shift;
say join ", ", perfect_totients($N);
