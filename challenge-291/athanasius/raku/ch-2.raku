use v6d;

################################################################################
=begin comment

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

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2024 PerlMonk Athanasius #
#--------------------------------------#

#===============================================================================
=begin comment

Interface
---------
1. No command-line arguments are accepted.
2. If the constant TIMER is True, the time taken to run the script is appended
   to the output.

Algorithm
---------
(1) C(52, 5) = 52! / (5! × 47!) = 2,598,960.

(2) Brute force. Subroutine rank-all-hands() generates all possible hands in
    ascending order. As each hand is generated, it is analysed by subroutine
    rank-hand(), and its rank is added to the corresponding tally in the array
    @hand-ranks.

(3) Confirms that the total of (2) equals the output of (1).

Performance
-----------
Running on Rakudo™ v2023.06 under Windows 11 64-bit, the script takes about 4
minutes to complete -- an order of magnitude slower than the Perl equivalent.

Reference
---------
http://www.codethrowdown.com/5CardSingleDeckHands.txt

=end comment
#===============================================================================

use Test;

# The 10 hand-ranking categories, in descending order

enum Hand-Ranks < FiveOfAKind StraightFlush FourOfAKind FullHouse Flush
                  Straight    ThreeOfAKind  TwoPair     OnePair   HighCard >;

# The 13 card ranks, in ascending order, with Ace low

enum Card-Ranks < Ace Two Three Four Five Six Seven Eight Nine Ten Jack Queen
                  King >;

my Bool constant TIMER = True;
my Int  constant DEAL  =    5;
my Int  constant PACK  =   52;
my Int  constant RANKS =   10;

#-------------------------------------------------------------------------------
BEGIN
#-------------------------------------------------------------------------------
{
    "\nChallenge 291, Task #2: Poker Hand Rankings (Raku)\n".put;
}

#===============================================================================
sub MAIN()
#===============================================================================
{
    my DateTime $t0    = DateTime.now   if TIMER;
    my UInt     $hands = count-hands();

    "(1) %s different %d-card hands can be dealt from a pack of %d cards\n\n".
        printf: commify( $hands ), DEAL, PACK;

    my UInt @hand-ranks = 0 xx RANKS;
    my UInt $count      = rank-all-hands( @hand-ranks );

    $count == $hands or die 'FAIL: Incorrect number of hands ranked';

    my UInt $sum  = 0;
            $sum += $_ for @hand-ranks;

    print-rank-counts( @hand-ranks, $sum );

    $sum == $hands      or die 'FAIL: Ranks sum does not equal number of hands';

    '(3) The total in (2) equals the count in (1)'.put;

    my DateTime $t = DateTime.now       if TIMER;
    "\n%.1f seconds\n".printf: $t - $t0 if TIMER;
}

#-------------------------------------------------------------------------------
sub count-hands( --> UInt:D )
#-------------------------------------------------------------------------------
{
    # C(52, 5) = 52! / (5! × 47!)

    my UInt $count    = [*] (PACK - DEAL + 1) .. PACK;
            $count div= $_ for 1 .. DEAL;

    return $count;
}

#-------------------------------------------------------------------------------
sub rank-all-hands( List:D[UInt:D] $hand-ranks --> UInt:D )
#-------------------------------------------------------------------------------
{
    my UInt ($count, @cards) = 0, |(Ace .. Five);

    while (1)
    {
        ++$count;
        rank-hand( @cards, $hand-ranks );

        if (++@cards[ 4 ] == PACK)
        {
            @cards[ 4 ] = @cards[ 3 ] + 2;

            if (++@cards[ 3 ] == PACK - 1)
            {
                @cards[ 3 ] = @cards[ 2 ] + 2;
                @cards[ 4 ] = @cards[ 3 ] + 1;

                if (++@cards[ 2 ] == PACK - 2)
                {
                    @cards[ 2  ] = @cards[ 1      ] + 2;
                    @cards[ $_ ] = @cards[ $_ - 1 ] + 1 for 3 .. 4;

                    if (++@cards[ 1 ] == PACK - 3)
                    {
                        @cards[ 1  ] = @cards[ 0      ] + 2;
                        @cards[ $_ ] = @cards[ $_ - 1 ] + 1 for 2 .. 4;

                        last if ++@cards[ 0 ] == PACK - 4;
                    }
                }
            }
        }
    }

    return $count;
}

#-------------------------------------------------------------------------------
sub rank-hand( List:D[UInt:D] $hand, List:D[UInt:D] $hand-ranks )
#-------------------------------------------------------------------------------
{
    my UInt @card-ranks  = 0 xx 13;
    my UInt @card-suits  = 0 xx  4;
    my Bool $is-straight = True;
    my UInt $last-rank;

    for @$hand -> UInt $card
    {
        my UInt $rank = ($card / 4).floor;
        my UInt $suit =  $card % 4;

        ++@card-ranks[ $rank ];
        ++@card-suits[ $suit ];

        # For straights, aces rank both low (A-2-3-4-5) and high (T-J-Q-K-A)

        $is-straight = False if $is-straight &&
                                $last-rank.defined && $rank != $last-rank + 1 &&
                              !($rank == Ten && $last-rank == Ace);
        $last-rank   = $rank;
    }

    my UInt ($rank1, $rank2) = (@card-ranks.sort)[ *-1, *-2 ];
    my UInt  $max-suit = max @card-suits;
    my Bool  $is-flush = $max-suit == DEAL;
    my UInt  $index    = $rank1 == 5                 ?? FiveOfAKind   !!
                         $is-straight && $is-flush   ?? StraightFlush !!
                         $rank1 == 4                 ?? FourOfAKind   !!
                         $rank1 == 3  && $rank2 == 2 ?? FullHouse     !!
                         $is-flush                   ?? Flush         !!
                         $is-straight                ?? Straight      !!
                         $rank1 == 3                 ?? ThreeOfAKind  !!
                         $rank1 == 2  && $rank2 == 2 ?? TwoPair       !!
                         $rank1 == 2                 ?? OnePair       !!
                                                        HighCard;
    ++$hand-ranks[ $index ];
}

#-------------------------------------------------------------------------------
sub print-rank-counts( List:D[UInt:D] $hand-ranks, UInt:D $sum )
#-------------------------------------------------------------------------------
{
    ("(2) The number of hands that can be dealt for each rank:\n" ~
     "      Rank  1. Five of a kind:  %9s\n"                      ~
     "      Rank  2. Straight Flush:  %9s\n"                      ~
     "      Rank  3. Four of a Kind:  %9s\n"                      ~
     "      Rank  4. Full House:      %9s\n"                      ~
     "      Rank  5. Flush:           %9s\n"                      ~
     "      Rank  6. Straight:        %9s\n"                      ~
     "      Rank  7. Three of a Kind: %9s\n"                      ~
     "      Rank  8. Two Pair:        %9s\n"                      ~
     "      Rank  9. One Pair:        %9s\n"                      ~
     "      Rank 10. High Card        %9s\n"                      ~
     "                                ---------\n"                ~
     "      Total:                    %9s\n"                      ~
     "                                =========\n\n").printf:
        (|$hand-ranks, $sum).map: { commify( $_ ) };
}

#-------------------------------------------------------------------------------
sub commify( UInt:D $s --> Str:D )
#-------------------------------------------------------------------------------
{
    # Adapted from the Raku commatize() subroutine in "Commatizing numbers" at
    # _Rosetta Code_, https://rosettacode.org/wiki/Commatizing_numbers#Raku

    return $s.subst: :continue( 0 ),
                     :1st,
                     / <[ 1..9 ]> <[ 0..9 ]>* /,
                     *.flip.comb( / <{ ".**1..3" }> / ).join( ',' ).flip;
}

#-------------------------------------------------------------------------------
sub USAGE()
#-------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

################################################################################
