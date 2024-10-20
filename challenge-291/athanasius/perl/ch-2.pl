#!perl

################################################################################
=comment

Perl Weekly Challenge 291
=========================

TASK #2
-------
*Poker Hand Rankings*

Submitted by: Robbie Hatley

A draw poker hand consists of 5 cards, drawn from a pack of 52: no jokers, no
wild cards. An ace can rank either high or low.

Write a script to determine the following three things:

  1. How many different 5-card hands can be dealt?
  2. How many different hands of each of the 10 ranks can be dealt?
     See here for descriptions of the 10 ranks of Poker hands:
     https://en.wikipedia.org/wiki/List_of_poker_hands#Hand-ranking_categories
  3. Check the ten numbers you get in step 2 by adding them together
     and showing that they're equal to the number you get in step 1.

=cut
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=comment

Interface
---------
1. No command-line arguments are accepted.
2. If the constant TIMER is assigned a true value, the time taken to run the
   script is appended to the output.

Algorithm
---------
(1) C(52, 5) = 52! / (5! × 47!) = 2,598,960.

(2) Brute force. Subroutine rank_all_hands() generates all possible hands in
    ascending order. As each hand is generated, it is analysed by subroutine
    rank_hand(), and its rank is added to the corresponding tally in the array
    @hand_ranks.

(3) Confirms that the total of (2) equals the output of (1).

Performance
-----------
Running on perl v5.32.1 under Windows 11 64-bit, the script completes execution
in about 19 seconds.

Reference
---------
http://www.codethrowdown.com/5CardSingleDeckHands.txt

=cut
#===============================================================================

use v5.32;        # Enables strictures and warnings
use CLDR::Number;
use Const::Fast;
use List::Util    qw( max );

use constant TIMER => 1;

# The 10 hand-ranking categories, in descending order

use enum qw( FiveOfAKind StraightFlush FourOfAKind FullHouse Flush
             Straight    ThreeOfAKind  TwoPair     OnePair   HighCard );

# The 13 card ranks, in ascending order, with Ace low

use enum qw( Ace Two Three Four Five Six Seven Eight Nine Ten Jack Queen King );

const my $DEAL  =>  5;
const my $PACK  => 52;
const my $RANKS => 10;
const my $USAGE => "Usage:\n  perl $0\n";

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 291, Task #2: Poker Hand Rankings (Perl)\n\n";
}

#===============================================================================
MAIN:
#===============================================================================
{
    use if TIMER, 'Time::HiRes' => qw( gettimeofday tv_interval );

    my $t0    = [ gettimeofday ]  if TIMER;
    my $argc  = scalar @ARGV;
       $argc == 0 or error( "No command-line arguments expected, found $argc" );

    my $hands = count_hands();
    my $cldr  = CLDR::Number->new( locale => 'en' );
    my $decf  = $cldr->decimal_formatter;

    printf "(1) %s different %d-card hands can be dealt from a pack of %d " .
           "cards\n\n", $decf->format( $hands ), $DEAL, $PACK;

    my @hand_ranks = (0) x $RANKS;
    my $count  = rank_all_hands( \@hand_ranks );
       $count == $hands or die 'FAIL: Incorrect number of hands ranked';
    my $sum    = 0;
       $sum   += $_ for @hand_ranks;

    print_rank_counts( \@hand_ranks, $sum, $decf );

    $sum == $hands      or die 'FAIL: Ranks sum does not equal number of hands';

    print "(3) The total in (2) equals the count in (1)\n";

    my $t = tv_interval( $t0 )    if TIMER;
    printf "\n%.1f seconds\n", $t if TIMER;
}

#-------------------------------------------------------------------------------
sub count_hands
#-------------------------------------------------------------------------------
{
    # C(52, 5) = 52! / (5! × 47!)

    my $count  = 1;
       $count *= $_ for $PACK - $DEAL + 1 .. $PACK;
       $count /= $_ for 1 .. $DEAL;

    return $count;
}

#-------------------------------------------------------------------------------
sub rank_all_hands
#-------------------------------------------------------------------------------
{
    my ($hand_ranks, $count, @cards) = (shift, 0, Ace .. Five);

    while (1)
    {
        ++$count;
        rank_hand( \@cards, $hand_ranks );

        if (++$cards[ 4 ] == $PACK)
        {
            $cards[ 4 ] = $cards[ 3 ] + 2;

            if (++$cards[ 3 ] == $PACK - 1)
            {
                $cards[ 3 ] = $cards[ 2 ] + 2;
                $cards[ 4 ] = $cards[ 3 ] + 1;

                if (++$cards[ 2 ] == $PACK - 2)
                {
                    $cards[ 2  ] = $cards[ 1      ] + 2;
                    $cards[ $_ ] = $cards[ $_ - 1 ] + 1 for 3 .. 4;

                    if (++$cards[ 1 ] == $PACK - 3)
                    {
                        $cards[ 1  ] = $cards[ 0      ] + 2;
                        $cards[ $_ ] = $cards[ $_ - 1 ] + 1 for 2 .. 4;

                        last if ++$cards[ 0 ] == $PACK - 4;
                    }
                }
            }
        }
    }

    return $count;
}

#-------------------------------------------------------------------------------
sub rank_hand
#-------------------------------------------------------------------------------
{
    my ($hand, $hand_ranks) = @_;
    my  @card_ranks  = (0) x 13;
    my  @card_suits  = (0) x  4;
    my  $is_straight =  1;
    my  $last_rank;

    for my $card (@$hand)
    {
        my $rank = int( $card / 4 );
         ++$card_ranks[ $rank ];
        my $suit = $card % 4;
         ++$card_suits[ $suit ];

        # For straights, aces rank both low (A-2-3-4-5) and high (T-J-Q-K-A)

        $is_straight = 0 if $is_straight &&
                            defined $last_rank && $rank != $last_rank + 1 &&
                          !($rank == Ten && $last_rank == Ace);
        $last_rank   = $rank;
    }

    my ($rank1, $rank2) = (sort @card_ranks)[ -1, -2 ];
    my  $max_suit = max @card_suits;
    my  $is_flush = $max_suit == $DEAL;
    my  $index    = $rank1 == 5                 ? FiveOfAKind   :
                    $is_straight && $is_flush   ? StraightFlush :
                    $rank1 == 4                 ? FourOfAKind   :
                    $rank1 == 3  && $rank2 == 2 ? FullHouse     :
                    $is_flush                   ? Flush         :
                    $is_straight                ? Straight      :
                    $rank1 == 3                 ? ThreeOfAKind  :
                    $rank1 == 2  && $rank2 == 2 ? TwoPair       :
                    $rank1 == 2                 ? OnePair       : HighCard;
              
    ++$hand_ranks->[ $index ];
}

#-------------------------------------------------------------------------------
sub print_rank_counts
#-------------------------------------------------------------------------------
{
    my ($hand_ranks, $sum, $decf) = @_;

    printf "(2) The number of hands that can be dealt for each rank:\n" .
           "      Rank  1. Five of a kind:  %9s\n" .
           "      Rank  2. Straight Flush:  %9s\n" .
           "      Rank  3. Four of a Kind:  %9s\n" .
           "      Rank  4. Full House:      %9s\n" .
           "      Rank  5. Flush:           %9s\n" .
           "      Rank  6. Straight:        %9s\n" .
           "      Rank  7. Three of a Kind: %9s\n" .
           "      Rank  8. Two Pair:        %9s\n" .
           "      Rank  9. One Pair:        %9s\n" .
           "      Rank 10. High Card        %9s\n" .
           "                                ---------\n" .
           "      Total:                    %9s\n" .
           "                                =========\n\n",
           map { $decf->format( $_ ) } @$hand_ranks, $sum;
}

#-------------------------------------------------------------------------------
sub error
#-------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

################################################################################
