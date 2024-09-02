#!/usr/bin/env perl
# Perl weekly challenge 285
# Task 2:  Making Change
#
# See https://wlmb.github.io/2024/09/02/PWC285/#task-2-making-change
use v5.36;
use Memoize;
die <<~"FIN" unless @ARGV;
    Usage: $0 A1 A2...
    to find in how many ways can the amounts Ai can be
    formed with coins (pennies, nickels, dimes, quartes
    and half-dollars)
    FIN
memoize qw(number_of_ways);
my @values=(1,5,10,25,50); # sorted
my $large=1+$values[-1]; # larger than largest coin
for(@ARGV){
    say "$_ -> ",number_of_ways($_+$large, $large)
}
sub number_of_ways($amount,$first_coin){
    return 0 if $first_coin>$amount;
    return 1 if $first_coin==$amount;
    my $total;
    $total+=number_of_ways($amount-$first_coin, $_)for grep{$_<=$first_coin}@values;
    return $total;
}
