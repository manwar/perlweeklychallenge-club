#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-2.pl < input-file
#

#
# There are two games known as NIM.
# First, there is the interesting game, where the game starts
# off with multiple heaps of tokens, and on each turn, a player
# can take one or more tokens from exactly one heap. The player
# taking the last token loses.
#
# The game described in the challenge is better known as the
# subtraction game. If a move has each player take between 
# 1 and k tokens, and the game starts off with N tokens, the game
# is a win for the second player, if and only if N == 0 (mod k + 1).
#
# Since we start off with 12 tokens, and we can take 1, 2, or 3
# tokens, the game is a win for player 2.
#
# In fact, with perfect play, there are only 27 possible games -- and
# they all have the second player win at the third move.
#
# If the first player takes t tokens, than the second player takes 4 - t
# tokens. Then, after the first move, 8 tokens are left; after the second
# move, there are 4 tokens left; and after the third move, there are 0 
# tokens left, leading to a win of the second player.
#

#
# So, we will just ask 3 times how many tokes you want to play, and
# have "the computer" reply. The computer always wins.
#

$| = 1;

my $tokens   = 12;
my $max_take =  3;
while ($tokens > 0) {
    printf "How many tokens do you take? (%2d token%s are left) " =>
                    $tokens, $tokens == 1 ? "" : "s";
    chomp (my $t = <>);
    redo unless $t =~ /^\s*[0-9]+\s*$/ && 1 <= $t <= $max_take;
    my $takes = $max_take + 1 - $t;
    printf "Computer takes %d token%s\n" => $takes, $takes == 1 ? "" : "s";
    $tokens -= ($max_take + 1);
}

say "Computer wins";
