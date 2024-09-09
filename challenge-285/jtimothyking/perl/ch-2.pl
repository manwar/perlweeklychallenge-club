#!/usr/bin/perl
use v5.38;

# This script solves the problem "Making Change" in the PWC #285.
# The input is a single integer representing the amount of money to make change for.
# The output is the number of ways to make change for that amount using the coins 1, 5, 10, 25, 50.

my $amount = <>;
chomp $amount;
die "Invalid input: $amount" unless $amount =~ /^\d+$/;

# Calculate the number of ways to make change for the given amount
# using space-optimized tabulation (aka space-optimized DP).
my @coins = (1, 5, 10, 25, 50);
my @num_ways = (0) x ($amount + 1);
$num_ways[0] = 1;
for my $coin (@coins) {
    for my $i ($coin..$amount) {
        $num_ways[$i] += $num_ways[$i - $coin];
    }
}

say $num_ways[$amount];

__END__
