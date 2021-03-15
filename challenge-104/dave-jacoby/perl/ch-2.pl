#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ postderef say signatures state };
no warnings qw{ experimental };

nim_game(12);

sub nim_game( $tokens ) {
    my $plural;
    while ($tokens) {
        $plural = $tokens == 1 ? 'token' : 'tokens';
        say qq{There are $tokens $plural};

        # you
        my $pp = player_choice($tokens);
        $plural = $pp == 1 ? 'token' : 'tokens';
        say qq{    You chose $pp $plural \n};
        if ( $tokens == $pp ) {
            say 'You have won!';
            exit;
        }
        $tokens -= $pp;

        # opponent
        my $op = opponent_choice($tokens);
        $plural = $op == 1 ? 'token' : 'tokens';
        say qq{    Opponent chose $op $plural \n};
        if ( $tokens == $op ) {
            say 'Opponent has won!';
            exit;
        }
        $tokens -= $op;
    }
}

sub player_choice( $tokens ) {
    my $max = 3;
    $max = $tokens if $tokens < $max;
    my $list = join ', ', 1 .. $max;
    my $c;
    while ( !defined $c ) {
        say qq{    Choose your tokens ($list)};
        my $d = <>;
        $d =~ s/\D//gmix;
        if ( length $d > 0 && $d > 0 && $d <= $max ) { $c = $d }
        else                                         { say 'Not valid input' }
    }
    return $c;
}

# sneaky opponent AI
sub opponent_choice( $tokens ) {
    return 3 if $tokens == 3;
    return 2 if $tokens == 2;
    return 1;
}
