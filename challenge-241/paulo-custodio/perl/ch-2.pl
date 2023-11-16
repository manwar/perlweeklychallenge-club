#!/usr/bin/env perl

# Challenge 241
#
# Task 2: Prime Order
# Submitted by: Mohammad S Anwar
#
# You are given an array of unique positive integers greater than 2.
#
# Write a script to sort them in ascending order of the count of their prime
# factors, tie-breaking by ascending value.
# Example 1
#
# Input: @int = (11, 8, 27, 4)
# Output: (11, 4, 8, 27))
#
# Prime factors of 11 => 11
# Prime factors of  4 => 2, 2
# Prime factors of  8 => 2, 2, 2
# Prime factors of 27 => 3, 3, 3

use Modern::Perl;

sub is_prime {
    my($n) = @_;
    return 0 if $n <= 1;
    return 1 if $n <= 3;
    return 0 if ($n % 2)==0 || ($n % 3)==0;
    for (my $i = 5; $i*$i <= $n; $i += 6) {
        return 0 if ($n % $i)==0 || ($n % ($i+2))==0;
    }
    return 1;
}

sub prime_factors {
    my($n) = @_;
    my @factors;
    my $p = 0;
    while ($n > 1) {
        do { $p++; } while (!is_prime($p));
        while ($n % $p == 0) {
            push @factors, $p;
            $n /= $p;
        }
    }
    return @factors;
}

# parse args
@ARGV>0 or die "ch-2 n n...\n";
my @nums = @ARGV;

# process
@nums = map { $_->[0] }
        sort {
            my(@fa) = @{$a->[1]};
            my(@fb) = @{$b->[1]};
            if (@fa != @fb) { return scalar(@fa) - scalar(@fb); }
            for my $i (0 .. $#fa) {
                if ($fa[$i] != $fb[$i]) { return $fa[$i] - $fb[$i]; }
            }
            return 0;
        }
        map {[$_, [prime_factors($_)]]} @nums;

# output
say "@nums";
