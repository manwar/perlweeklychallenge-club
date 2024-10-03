#!/usr/bin/env perl

# Challenge 172
#
# Task 1: Prime Partition
# Submitted by: Mohammad S Anwar
#
# You are given two positive integers, $m and $n.
#
# Write a script to find out the Prime Partition of the given number. No
# duplicates allowed.
#
# For example,
#
# Input: $m = 18, $n = 2
# Output: 5, 13 or 7, 11
#
# Input: $m = 19, $n = 3
# Output: 3, 5, 11

use Modern::Perl;
use List::Util 'sum';

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

sub next_prime {
    my($n) = @_;
    return 2 if $n <= 1;
    my $p = $n;
    1 while !is_prime(++$p);
    return $p;
}

sub primes {
    my($n) = @_;
    my $p = 2;
    my @primes;
    while ($p <= $n) {
        push @primes, $p;
        $p = next_prime($p);
    }
    return @primes;
}

sub odometer_increment {
    my($limit, @n) = @_;
    my $i = $#n;
    while (++$n[$i] >= $limit) {
        $n[$i--] = 0;
        if ($i < 0) {
            unshift @n, 0;
            $i = 0;
        }
    }
    return @n;
}

sub has_duplicates {
    my(@n) = @_;
    my %seen;
    for (@n) {
        return 1 if $seen{$_}++;
    }
    return 0;
}

sub prime_partition {
    my($m, $n) = @_;
    my @primes = primes($m);
    my @idx = (0) x $n;
    while (@idx == $n) {
        if (!has_duplicates(@idx)) {
            my @terms = @primes[@idx];
            return @terms if sum(@terms) == $m;
        }
        @idx = odometer_increment(scalar(@primes), @idx);
    }
    return ();
}

@ARGV==2 or die "usage: ch-1.pl m n\n";
my($m, $n) = @ARGV;
say join ", ", prime_partition($m, $n);
