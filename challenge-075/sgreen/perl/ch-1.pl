#!/usr/bin/perl

use strict;
use warnings;
use List::Util qw(uniqnum);
use 5.10.1;

sub _calculate {
    my ( $coins, $sofar, $remaining_amount ) = @_;
    my @solutions = ();

    # To ensure we don't get duplicate results (e.g 2 + 4 / 4 + 2), we
    #  only consider coins greater than or equal to the last used coin
    my $last_coin = scalar(@$sofar) ? $sofar->[-1] : 0;

    foreach my $coin (@$coins) {
        next if $coin < $last_coin;

        if ( $coin < $remaining_amount ) {
            # We need to find some more coins
            push @solutions,
              _calculate(
                $coins,
                [ @$sofar, $coin ],
                $remaining_amount - $coin
              );
        }
        elsif ( $coin == $remaining_amount ) {
            # We have a solution!
            push @solutions, [ @$sofar, $coin ];
            # Higher coins will exceed the remaining amount
            last;
        }
        else {
            # This coin (and all larger coins) will exceed the remaining amount
            last;
        }
    }

    return @solutions;
}

sub main {
    my $S = pop;
    my @C = @_;

    # Sanity check the inputs
    if ( !scalar(@C) ) { die "Usage: $0 coin1 .. coin_n sum\n"; }
    foreach ( @C, $S ) {
        die "Value $_ is not a positive number"
          unless $_ > 0;
    }

    # We want to sort the coins numerically, and remove dups
    @C = uniqnum sort { $a <=> $b } map { 0 + $_ } @C;

    my @solutions = _calculate( \@C, [], $S );
    say join ', ', @$_ foreach @solutions;
}

main(@ARGV);
