#!/usr/bin/env perl

###########################################################################
# script name: ch-2.pl                                                    #
#                                                                         #
# https://github.com/user-person                                          #
#                                                                         #
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-052/         #
#                                                                         #
# Lucky Winner                                                            #
# Suppose there are following coins arranged on a table in a line in      #
# random order                                                            #
#                                                                         #
# 1, 50p, 1p, 10p, 5p, 2, 2p                                              #
#                                                                         #
# Suppose you are playing against the computer. Player can only pick one  #
# coin at a time from either ends. Find out the lucky winner, who has     #
# the larger amounts in total?20p, order.                                 #
#                                                                         #
###########################################################################

# Coins total 3.88. 2 > 1.88 . If a player gets the L2 coin, they win the game.

# Given sufficiently intelligent players, whoever gets the first turn wins the game.

use strict;
use warnings;
use diagnostics;

use List::Util qw/shuffle/;
use Term::ReadLine;

my $term = Term::ReadLine->new('input');
$term->ornaments(00,00,00,00);

my @coins = qw{ 1p 2p 5p 10p 20p 50p L1 L2 };

@coins = shuffle @coins;

my %coinVal = ( '1p'  => 0.01,  '2p' => 0.02, '5p' => 0.05, '10p' => 0.10,
                '20p' => 0.20, '50p' => 0.50, 'L1' => 1.00, 'L2'  => 2.00 );

my %bank = ( 'player' => 0, 'computer' => 0 );

my $turn = int rand 2;

sub l2Index {
    my $ret = -1;
  LOOP:
    for (my $i = 0; $i <= $#coins; ++$i) {
        if ($coins[$i] eq 'L2') {
            $ret = $i;
            last LOOP;
        }
    }
    return $ret;
}

sub takeCoin {
    my $choice = shift;
    my $who    = shift;

    if ($choice eq 'f') {
        $bank{$who} += $coinVal{ shift @coins };
    } else {                                     # "If you ain't first, you're last."
        $bank{$who} += $coinVal{ pop   @coins };
    }

    printf "%s: L %.2f\n\n", $who, $bank{$who};
}

sub playerChoice {
    my $fl   = "";
    my $loop = 1;

    my $prompt = "Type 'f' to choose the first coin. Type 'l' to choose the last coin. Type 'q' to quit:\n" ;
    print $prompt if scalar @coins > 1;

  ILOOP:
    while ($loop--) {

        if ( scalar @coins == 1) {  # Don't ask when there's only one choice.
            takeCoin('f','player');
            next ILOOP;
        }

        my $fl = $term->readline('> ');

        if ($fl eq 'f' or $fl eq 'l') {
            takeCoin($fl,'player');

        } elsif ($fl eq 'q') {
            exit;

        } else {
            print "Invalid choice.\n";
            ++$loop;
        }
    }
}

sub chooseGreater {
    $coinVal{$coins[0]} > $coinVal{$coins[-1]} ? takeCoin('f','computer') : takeCoin('l','computer');
}

sub computerChoice {
    # Grabs L2 off the end when available
    # Doesn't grab the item before L2 to free it up for player to win.
    # Otherwise, grabs whichever end is greater.
    # It doesn't always get the highest points, but it wins when that's possible.

    my $ind = l2Index();

    if (scalar @coins == 3) {   # Without this statement computer always chooses last (third)
        chooseGreater();        # when protecting L2 ( e.g. [first], L2, [last] )
                                # even if first is greater.
    } else {

        if ($ind == 0 or $ind == $#coins-1 ) {
            takeCoin('f','computer');

        } elsif ( $ind == $#coins or $ind == 1) {
            takeCoin('l','computer');

        } else {
            chooseGreater();
        }
    }
}

while (scalar @coins) {
    print "@coins\n";

    if ( $turn ) {
        playerChoice();
        --$turn;
    } else {
        computerChoice();
        ++$turn;
    }
}

if ( $bank{computer} > $bank{player} ) {
    printf "Computer Wins. Computer: L %.2f Player: L %.2f\n\n", $bank{computer}, $bank{player};
} else {
    printf "Player Wins. Player: L %.2f Computer: L %.2f\n\n", $bank{player}, $bank{computer};
}
