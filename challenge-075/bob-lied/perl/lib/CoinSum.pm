# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu syntax=perl:
#
# Copyright (c) 2020 Bob Lied
# The copyright notice above does not evidence any actual
# or intended publication of such source code.

#===============================================================================
# CoinSum.pm
#
# Description: 
#
#===============================================================================

package CoinSum;

use strict;
use warnings;
use 5.010;
use Carp;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT = qw(coinSum);
our @EXPORT_OK = qw();


my @ComboList;

sub _coinSum
{
    my ($depth, $target, $coinList, $coin, $combo) = @_;

    my $diff = $target - $coin;
    # say " depth=$depth, target = $target, coin = $coin, diff = $diff, list = [ @$coinList ], combo = [ @$combo ]";


    if ( $diff == 0 )
    {
        push @ComboList, [ @$combo ];
        # say "FOUND [ @$combo ]";
        return 0;
    }

    if ( $diff < 0 )
    {
        pop @$combo;
        # say "TOO FAR";
        return $diff;
    }

    my @remainingCoin = sort { $a < $b } grep { $_ <= $diff } @$coinList;
    for my $denom ( @remainingCoin )
    {
        push @$combo, $denom;
        _coinSum( $depth+1, $diff, \@remainingCoin, $denom, $combo );
        pop @$combo;
    }

}

sub coinSum
{
    my ($sum, @coins) = @_;
 
    # Sort denominations so largest is first.
    @coins = sort { $a < $b } @coins;

    while ( @coins )
    {
        # say "TOP: coin = $coins[0]";
        _coinSum(1, $sum, \@coins, $coins[0], [ $coins[0] ] );
        shift @coins;
    }

    return \@ComboList;
}

1;

