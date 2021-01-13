#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-2.pl
#
#        USAGE: ./ch-2.pl
#
#  DESCRIpTION: https://perlweeklychallenge.org/blog/perl-weekly-challenge-052/
#
#   Suppose there are following coins arranged on a table in a line in random order.
#
#    £1, 50p, 1p, 10p, 5p, 20p, £2, 2p
#
#   Suppose you are playing against the computer. player can only pick one coin at a time from either ends. Find out the lucky winner, who has the larger amounts in total?
#
#      OpTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: Lubos Kolouch,
# ORGANIZATION:
#      VERSION: 1.0
#      CREATED: 03/19/2020 08:46:11 pM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;
use List::Util qw/shuffle/;
use feature qw/say/;
use utf8;

binmode STDOUT, ':encoding(UTF-8)';

my @deck   = shuffle( '£1', '50p', '1p', '10p', '5p', '20p', '£2', '2p' );
my %values = (
    '£1' => 1,
    '50p' => 0.5,
    '1p'  => 0.01,
    '10p' => 0.1,
    '5p'  => 0.05,
    '20p' => 0.2,
    '£2' => 2,
    '2p'  => 0.02
);
my %players = ( 1 => 'Player', -1 => 'Computer' );
my @sides   = ( 'L', 'R' );
my %scores  = ( '1' => 0, '-1' => 0 );

sub do_draw {
    my $side = shift;

    return pop @deck if $side eq 'R';
    return shift @deck;

}

sub get_player_input {

    my $lr;
    while (1) {
        print 'Please input L for left or R for right side of the line:';
        $lr = <>;
        chomp $lr;
        $lr = uc($lr);
        last if $lr =~ /[LR]/;
    }

    return $lr;
}

sub play_round {

    my $who = shift;
    my $lr  = '';

    $who == 1? $lr = get_player_input: $lr = $sides[ rand @sides ];

    my $draw = do_draw($lr);
    $scores{$who} += $values{$draw};

    say $players{$who}
      . ' has drawn from '
      . $lr
      . ' and won '
      . $draw
      . ' and has now score '
      . $scores{$who};

}

sub end_game {
    if ($scores{1} > $scores{-1}) {
        say 'Player WON!';
    } elsif ($scores{1} < $scores{-1}) {
        say 'Computer WON!';
    } else {
        say "It's a tie!";
    }
}

sub play_game {

    my $who = -1;
    while (@deck) {
        $who *= -1;
        play_round($who);
    }

    end_game;
}

play_game( \@deck );

