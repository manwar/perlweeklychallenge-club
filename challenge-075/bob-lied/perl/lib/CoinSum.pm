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


my @Combo;

sub _coinSum
{
    my ($target, $denomList, $currentSum, $currentDenom, $comboNum = @_;

    return 0 if ( $currentSum > $target );

    return 1 if ( $currentSum == $target );

    my $count = 0;
    for my $denom ( @$denomList )
    {
        push @{$Combo[$comboNum]]  $denom;
        if ( $denom >= $currentDenom )
        {
            $comboNum += _coinSum($target, $denomList, $currentSum + $currentDenom, $denom, $comboNum);
        }
    }
    return $0;
}

sub coinSum
{
    my ($sum, @coins) = @_;

    _coinSum($sum, \@coins, 0, $coins[0], 0);

    return 0;
}

1;

