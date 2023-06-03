#!/usr/bin/perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub buy_pass ( $passes, $travel_on ) {
    if ( scalar(@$travel_on) == 0 ) {
        return 0;
    }

    my $first_day     = $travel_on->[0];
    my $minimum_spend = undef;

    foreach my $days ( keys %$passes ) {
        my $cost = $passes->{$days};
        my $spend =
          $cost +
          buy_pass( $passes,
            [ grep { $_ >= $first_day + $days } @$travel_on ] );
        if ( not defined($minimum_spend) or $spend < $minimum_spend ) {
            $minimum_spend = $spend;
        }
    }

    return $minimum_spend;
}

sub main (@array) {
    # Take the first three values off
    my %passes = ();
    $passes{1}  = shift @array;
    $passes{7}  = shift @array;
    $passes{30} = shift @array;

    # Note the days we want to travel on
    my @travel_on = sort { $a <=> $b } @array;
    my $spent     = buy_pass( \%passes, \@travel_on );
    say $spent;
}

main(@ARGV);

