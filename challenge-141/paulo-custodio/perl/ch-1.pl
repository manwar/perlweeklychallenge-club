#!/usr/bin/perl

# Challenge 141
#
# TASK #1 > Number Divisors
# Submitted by: Mohammad S Anwar
# Write a script to find lowest 10 positive integers having exactly 8 divisors.
#
# Example
# 24 is the first such number having exactly 8 divisors.
# 1, 2, 3, 4, 6, 8, 12 and 24.

use Modern::Perl;

use constant NUM_DIVISORS => 8;

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

sub next_number {
    my($n) = @_;

    for (;;) {
        $n++;
        my @divisors = divisors($n);
        return $n if @divisors == NUM_DIVISORS;
    }
}

my $num = shift||10;
my $n = 0;
for (1..$num) {
    $n = next_number($n);
    say $n;
}
