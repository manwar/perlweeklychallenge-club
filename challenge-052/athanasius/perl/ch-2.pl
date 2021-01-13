#!perl

################################################################################
=comment

Perl Weekly Challenge 052
=========================

Task #2
*Lucky Winner*

Suppose there are following coins arranged on a table in a line in random order.

    £1, 50p, 1p, 10p, 5p, 20p, £2, 2p

Suppose you are playing against the computer. Player can only pick one coin at a
time from either ends. Find out the lucky winner, who has the larger amounts in
total?

=cut
################################################################################

#--------------------------------------#
# Copyright © 2020 PerlMonk Athanasius #
#--------------------------------------#

#-------------------------------------------------------------------------------
=comment

Interpretation:
The number and denominations of the coins are fixed, but the order in which they
are arranged changes randomly with each game played.

Observations:
(1) The total value of the coins is £3.88, so the total value of the non-£2
    coins is £1.88, from which it follows that the winner is the player who
    picks the £2 coin.
(2) The player going first can always force a win.

Strategy:
(1) If the £2 coin is available, pick it.
(2) Otherwise: avoid picking a coin if it is immediately next to the £2 coin.
(3) Otherwise: pick the larger of the two coins.

Note: This strategy gives the best chance of winning, not of getting the highest
      amount. Step (3) is strictly not necessary: any choice will do as well
      here.

=cut
#-------------------------------------------------------------------------------

use strict;
use warnings;
use utf8;
use Const::Fast;
use List::Util qw( shuffle );

const my $BAR           => '-' x 18;
const my $PLAYER_STARTS =>  1;
const my %COINS         =>
         (
              '1p' =>   1,
              '2p' =>   2,
              '5p' =>   5,
             '10p' =>  10,
             '20p' =>  20,
             '50p' =>  50,
              '£1' => 100,
              '£2' => 200,
         );

BEGIN
{
    $| = 1;
    print "\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    printf "Challenge 052, Task #2: Lucky Winner (Perl)\n\n" .
           "%s moves first\n", $PLAYER_STARTS ? 'Player' : 'Computer';

    my  $computer       = 0;
    my  $player         = 0;
    my  @coins          = shuffle keys %COINS;
    my  $round          = 0;
    my ($move1, $move2) = $PLAYER_STARTS ? (\&player_move,   \&computer_move) :
                                           (\&computer_move, \&player_move);

    while (scalar @coins > 0)
    {
        $move1->( \$computer, \$player, \@coins, ++$round );
        $move2->( \$computer, \$player, \@coins, ++$round );
    }

    printf "\n%s\nGAME OVER\n"      .
             "  Player has £%.2f\n" .
             "Computer has £%.2f\n" .
             "%s WINS!\n%s\n",
              $BAR, $player / 100, $computer / 100,
              $player > $computer ? 'PLAYER' : 'COMPUTER', $BAR;
}

#-------------------------------------------------------------------------------
sub player_move
#-------------------------------------------------------------------------------
{
    my ($computer, $player, $coins, $round) = @_;

    printf "\n%d. Player has £%.2f\t" .
             "Computer has £%.2f\n\n" .
             "  Coins remaining: %s\n",
              $round, $$player / 100, $$computer / 100, join ', ', @$coins;

    my $key = 'L';

    if (scalar @$coins > 1)
    {
        do
        {
            printf '  Select  L[eft]  (%s) or R[ight] (%s): ', @$coins[0, -1];
            $key = uc <STDIN>;
            chomp $key;

        } until ($key eq 'L' || $key eq 'R');
    }

    my $coin  = $key eq 'L' ? shift @$coins : pop @$coins;
    $$player += $COINS{ $coin };

    printf "  Player picks:    %s%s\n", $coin,
            scalar @$coins == 0 ? ' (forced)' : '';
}

#-------------------------------------------------------------------------------
sub computer_move
#-------------------------------------------------------------------------------
{
    my ($computer, $player, $coins, $round) = @_;

    printf "\n%d. Player has £%.2f\t" .
             "Computer has £%.2f\n\n" .
             "  Coins remaining: %s\n",
              $round, $$player / 100, $$computer / 100, join ', ', @$coins;

    my $coin    = pick_coin($coins) eq 'L' ? shift @$coins : pop @$coins;
    $$computer += $COINS{ $coin };

    printf "  Computer picks:  %s%s\n",
            $coin, scalar @$coins == 0 ? ' (forced)' : '';
}

#-------------------------------------------------------------------------------
sub pick_coin
#-------------------------------------------------------------------------------
{
    my ($coins)          = @_;
    my  $coins_remaining = scalar @$coins;

    return 'L' if $coins_remaining == 1;                          # Forced move

    my ($left, $right) = @$coins[0, -1];

    return 'L' if $left  eq '£2';                                 # Strategy (1)
    return 'R' if $right eq '£2';

    if ($coins_remaining >= 4)
    {
        return 'L' if $coins->[-2] eq '£2';                       # Strategy (2)
        return 'R' if $coins->[ 1] eq '£2';
    }

    return $COINS{ $left } > $COINS{ $right } ? 'L' : 'R';        # Strategy (3)
}

################################################################################
