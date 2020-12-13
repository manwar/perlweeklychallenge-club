#! /opt/local/bin/perl
#
#       ethiopian_multiplication.pl
#
#       TASK #2 › Ethiopian Multiplication
#         Submitted by: Mohammad S Anwar
#         You are given two positive numbers $A and $B.
#
#         Write a script to demonstrate Ethiopian Multiplication using the given numbers.
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

## explanation in the heredoc

my $m = shift @ARGV // 149;
my $n = shift @ARGV // 127;

my $acc = 0;
$acc = $n unless $m % 2 == 0;

say<<"END";
Input: $m × $n

These numbers we will call m and n.
We will halve m, ignoring any remainder,
and double n until m reaches 1. At each
step along the way, if m is odd, we will
add n to the sum. When m reaches 1, the
running sum is the product of m × n

     m       n          sum
END


printf " %5d | %5d | %10d\n", $m, $n, $acc;
say      '-------+-------+------------';

while ($m > 1) {
    $m = int $m/2;
    $n *= 2;
    $acc += $n unless $m % 2 == 0;
    printf " %5d | %5d | %10d\n", $m, $n, $acc;
}

say      '----------------------------';
printf "  Product:       %10d\n", $acc;

say eth_mult(149,127);
say eth_mult_bitwise(149,127);
say eth_mult_binary(149,127);

## ## ## ## ## SUBS:

## stripped version sans narrative
sub eth_mult {
    my ($m, $n) = @_;
    my $acc;
    $m % 2 == 0 ? $acc = 0 : $acc = $n;

    while ($m > 1) {
        $m = int $m/2;
        $n *= 2;
        $acc += $n unless $m % 2 == 0;
    }
    return $acc;
}

## the same function using bitwise operators
## to do the halving, doubling and comparisons
sub eth_mult_bitwise {
    my ($m, $n) = @_;
    my $acc = $m & 1 ? $n : 0;

    while ($m ^ 1) {
        $m = $m>>1;
        $n = $n<<1;
        $m & 1 and $acc += $n;
    }
    return $acc;
}

## the same function basing the switch on
## individual binary bits
sub eth_mult_binary {
    my ($m, $n) = @_;
    my $mb = sprintf "%b", $m;
    my $acc;

    for my $idx (reverse 0..length $mb - 1) {
        next unless substr $mb, $idx, 1;
        $acc += $n<<(length($mb) - $idx - 1);
    }
    return $acc;
}
