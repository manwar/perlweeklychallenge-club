#!/usr/bin/env perl

use Modern::Perl;

my @COINS = (50,25,10,5,1);

my $amount = shift//0;
my $num_ways = compute_num_ways($amount, @COINS);
say $num_ways;

sub compute_num_ways {
    my($amount, @coins) = @_;
    while (@coins>1 && $coins[0]>$amount) {
        shift @coins;
    }
    return 1 if @coins==1;      # return in cents
    my $count;
    for (my $v = 0; $v <= $amount; $v += $coins[0]) {
        $count += compute_num_ways($amount-$v, @coins[1..$#coins])
    }
    return $count;
}
