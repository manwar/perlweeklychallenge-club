#!/usr/bin/env perl

=pod

--------------------------------------------------------------------------------------------------------------
TITLE AND ATTRIBUTION:
Solutions in Perl for The Weekly Challenge 291-2,
written by Robbie Hatley on Tue Oct 15, 2024.

--------------------------------------------------------------------------------------------------------------
PROBLEM DESCRIPTION:
Task 291-2: "Poker Hand Rankings"
Submitted by: Robbie Hatley
A draw poker hand consists of 5 cards, drawn from a pack of 52:
no jokers, no wild cards. An ace can rank either high or low.

Write a script to determine the following three things:

1. How many different 5-card hands can be dealt?
2. How many different hands of each of the 10 ranks can be dealt?
   See here for descriptions of the 10 ranks of Poker hands:
   https://en.wikipedia.org/wiki/List_of_poker_hands
3. Check the ten numbers you get in step 2 by adding them together
   and showing that they're equal to the number you get in step 1.

--------------------------------------------------------------------------------------------------------------
PROBLEM NOTES:
This problem involves a lot of thinking about how probability works. The solution will be heavily-dependent
on the mathematical principle of "combinations", and thus also factorials. One could use CPAN module
"Math::Combinatorics" for this, but factorials and combinations are so simple that I just rolled my own.
The rest is just a matter of calculating "ways" to get each rank, then adding them together and showing that
the sum is equal to 52c5 (the total number of combinations of 52 things taken 5-at-a-time).

--------------------------------------------------------------------------------------------------------------
IO NOTES:
This program takes no input.

Output is to STDOUT and will be the number of possible 5-card poker hands, followed by the numbers of ways to
obtain each of the 10 "ranks", followed by the sum of those 10 "ways", showing that they sum to the number of
possible 5-card Poker hands.

=cut

# ------------------------------------------------------------------------------------------------------------
# PRAGMAS, MODULES, AND SUBS:

   use v5.36;

   # x!:
   sub fact ($x) {
      my $f = 1;
      for my $i (2..$x) {$f *= $i}
      $f
   }

   # Unordered combinations
   # of x things taken y-at-a-time:
   sub comb ($x, $y) {
      fact($x)/fact($x-$y)/fact($y);
   }

# ------------------------------------------------------------------------------------------------------------
# MAIN BODY OF PROGRAM:

# Note that in 5-Card Aces-High-Or-Low Nothing-Wild Draw Poker, there is no "Five-Of-A-Kind" because that
# would require a wildcard. So the highest possible rank is "Straight Flush", or "Royal Flush" if one chooses
# to consider "Royal Flush" (ace-high straight flush) to be its own rank; I DO so elect, in this solution,
# thus giving 10 ranks instead of the usual 9. That doesn't affect the sum of "ways"; it just splits the
# 40 "ways" of "Straight Flush" into 4 + 36.

# Also note that the worst rank, "High Card", can also be called "No Pair"; I DO so elect, in this solution.

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Rank 1: Royal Flush:
my $RF = 1 * 4;               # TJQKA in each of 4 suits.                                                    4

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Rank 2: Straight Flush:
my $SF = 9 * 4;               # A-5, 2-6, 3-7, 4-8, 5-9, 6-T, 7-J, 8-Q, 9-K in each of 4 suits.             36

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Rank 3: Four-Of-A-Kind:
my $FK = 13                   # 13 poss vals  for quartet
       * 1                    # 1  poss suit  combos for quartet (namely one-each of the 4 suits)
       * 12                   # 12 poss vals  for 5th card
       * 4;                   # 4  poss suits for 5th card                                                 624

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Rank 4: Full House:
my $FH = 13                   # 13 poss vals  for trio
       * comb(4,3)            # 4c3=4 poss suit combos for trio
       * 12                   # 12 poss vals  for pair
       * comb(4,2);           # 4c2=6 poss suit combos for pair                                           3744

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Rank 5: Flush:
my $FL = (comb(13,5)-10)*4;   # (13c5-10=1277) val combos for each of 4 suits                             5108

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Rank 6: Straight:
my $ST = 10*(4**5-4);         # 10 poss val combos for each of (4**5-4) suit combos                     10_200

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Rank 7: Three-Of-A-Kind:
my $TK = 13                   # 13 poss vals for trio
       * comb(4,3)            # 4c3=4 poss suit combos for trio
       * comb(12,2)           # 12c2=66 poss val combos for 4th and 5th cards
       * 4                    # 4 poss 4th-card suits
       * 4;                   # 4 poss 5th-card suits                                                   54_910

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Rank 8: Two Pairs:
my $TP = comb(13,2)           # 13c2=78 poss pairs of pair values
       * comb(4,2)            # 4c2=6 first pair suit combos
       * comb(4,2)            # 4c2=6 secnd pair suit combos
       * 11                   # 11 poss vals  for 5th card
       * 4;                   # 4  poss suits for 5th card                                             123_552

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Rank 9: One Pair:
my $OP = 13                   # 13 poss pair values
       * comb(4,2)            # 4c2=6 suit combos for pair
       * comb(12,3)           # 12c3=220 val combos for 3rd, 4th, 5th cards
       * 4                    # 4 poss 3rd-card suits
       * 4                    # 4 poss 4th-card suits
       * 4;                   # 4 poss 5th-card suits                                                1_098_240

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Rank 10: No Pair:
my $ZP = (comb(13,5)-10)      # (13c5 poss  val combos, minus 10 for straights) = 1277
       * (4**5 - 4);          # (4**5 poss suit combos, minus  4 for flushes  ) = 1020               1_302_540

printf "Number of Poker Hands      = %7d\n", comb(52,5);
printf "Number of Royal    Flushes = %7d\n", $RF;
printf "Number of Straight Flushes = %7d\n", $SF;
printf "Number of Four-Of-A-Kinds  = %7d\n", $FK;
printf "Number of Full Houses      = %7d\n", $FH;
printf "Number of Flushes          = %7d\n", $FL;
printf "Number of Straights        = %7d\n", $ST;
printf "Number of Three-Of-A-Kinds = %7d\n", $TK;
printf "Number of Two-Pairs        = %7d\n", $TP;
printf "Number of One-Pairs        = %7d\n", $OP;
printf "Number of No-Pairs         = %7d\n", $ZP;
printf "Sum    of Poker Ranks      = %7d\n", $RF+$SF+$FK+$FH+$FL+$ST+$TK+$TP+$OP+$ZP;
