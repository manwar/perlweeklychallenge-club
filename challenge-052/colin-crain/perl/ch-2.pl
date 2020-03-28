#! /opt/local/bin/perl
#
#       luck_hustle.pl
#
#       TASK #2
#         Lucky Winner
#             Suppose there are following coins arranged on a table in a line in random order.
#
#                   £1, 50p, 1p, 10p, 5p, 20p, £2, 2p
#
#             Suppose you are playing against the computer. Player can only pick one coin at a
#             time from either ends. Find out the lucky winner, who has the larger amounts in
#             total?
#
#         Comments: Right out of the gate, it's a little ambiguous what exactly
#             is going on here. At first I tried not to overthink it and decided
#             it was a simple game of chance we were modeling, where each player
#             takes the highest coin available and the winner has the largest
#             pot. Just two people, perhaps sitting at a bar over drinks, having
#             a small innocent wager to pass the time.
#
#             I'm pretty sure this was the intent, two players and one lucky
#             winner. But this got me thinking about alternate strategies, where
#             one might chose not to take the largest coin now, to set up for a
#             larger prize later. On closer examination of the terms, with
#             careful play there is no luck at all.
#
#             The game uses 8 coins, one of each of the currency of the United
#             Kingdom. Summing these together gives us 388 pence, which you may
#             immediately notice, is less than half of the largest coin, £2 or
#             200p. Consequently, whoever gets the £2 coin wins the game.
#
#             This revelation shifts the goal from maximizing the gain per turn
#             to aquiring the £2 coin, and it turns out that, much like
#             tic-tac-toe, with an 8 coin game the first to draw will invariably
#             win. So there is no lucky winner; rather than a friendly wager it
#             appears we have a bar bet hustle, with a insincere instigator
#             pulling a fast one on an unsuspecting dupe.
#
#         Method: The algorithm to win is straightforward: if the £2 coin is at
#             any time exposed, take it. If it is contained within the line, it
#             will have some number of coins surrounding it to the left and
#             right. The first draw takes a coin from whichever side has a
#             larger count of coins. Because there are 7 coins and the £2 piece,
#             the surrounding coins will always be odd for the first draw, and
#             so one side will always be larger than the other. The second
#             player is given an even count and is forced to break the symmetry,
#             which the first player then reestablishes. This play proceeds until
#             eventually the £2 coin is surrounded by a single coin on each
#             side, and the second player, by taking one or the other, reveals
#             the prize.
#
#             After the £2 piece is secured, the first player proceeds by moving
#             the focus to the next largest remaining coin and starting the
#             process anew, repeating until there are no more coins to draw.
#
#             As for the hapless fate of the second player, mimicking the
#             strategy of the first will not work, and puts him or her at a
#             disadvantage compared to just getting the best coins available.
#             Because we should always do our best even when destiny is fated
#             against us, to fight the good fight at Ragnarök, a strategy of
#             taking the larget coin available is enacted. If the play is
#             winner-take-all, it really doesn't matter what the second player
#             does, as no style of play can obtain the £2 coin. But as stated in
#             stanza 77 of the Hávamál:
#
#                 Deyr fé,                    Cattle die,
#                 deyja frændur,              kinsmen die,
#                 deyr sjálfur ið sama;       you yourself will die,
#                 ek veit einn                I know one thing
#                 at aldri deyr               that never dies
#                 dómr um dauðan hvern."      the reputation* of the dead
#
#             Perhaps it would be better to reference the famous koan by the
#             Master Ma-Tzu Daoyi:
#
#                 "If you call this a stick, I will hit you with it.
#                 If you do not call this a stick, I will hit you with it.
#                 What do you choose to do?"
#
#             The enlightenment of the double-bind is to not play the game.
#
#             * the crux here in translation is the word dómr, a cognate with
#             the Old English word döm, or "doom". This differs from the modern
#             meaning somewhat, not focusing on the downfall aspect, but rather
#             the fatalism of the judgment that comes at that moment. Hence
#             "judgment" is closer. In the pre-Christian Norse world a man was judged
#             throughout his life by his actions, first by his peers and later by
#             the gods themselves. Thus the judgment is the thing rather than
#             the act, the record of life actions judged. Thus I have gone with
#             the word "reputation" here, as this perhaps best portrays that
#             record.
#
#         The Hustle: One scenario would be for the hustler to strike up a
#             conversation with the mark, to pool some coins and play a game:
#             winner take all and the loser to buy a round. The hustler even
#             produces the two-pound coin as a show of good faith, here we are
#             willing to risk a sizable stake, more than half! It's important
#             not to put too much weight in the one-of-every-coin angle, as this
#             variable can then be manipulated later; the change present should
#             appear to be random. By strategically placing coins in several
#             pockets the final count of eight coins can be assembled without
#             appearing contrived. Producing the largest coin could be a
#             pretense to draw first, which the hustler knows will ensure a win.
#             The hustler pockets the change. When the mark objects, he is
#             prompted to buy another round of drinks and obtain some more
#             change, stating "Ok this time you draw first!" . Once the change
#             is placed on the table, the hustler pushes some back saying "too
#             much" and then completes the pot with his half of the stake. This
#             both gives the semblance of goodwill again, a show to not appear
#             greedy, but more importantly gives full opportunity to craft the
#             makeup of the pot. This time an additional coin is slipped in to
#             make the final count odd. As long as a single large coin
#             dominates, with an odd starting count the second player to draw,
#             in this case the hustler again, will always win.
#
#         One-Liner: whist not particularly useful, the following short program
#             is technically correct and does not waste valuable resources
#             computing pointless details:
#
#                 perl -e 'print "First player to draw is the lucky winner.\n"'
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

my @draw = shuffle( 100, 50, 1, 10, 5, 20, 200, 2 );
my $coins = \@draw;

say "draw:\n", join ', ', $coins->@*;
say '';

my %player = map {$_ => 0} (0,1);
my $turn = 0;

while (scalar $coins->@*) {
    my $taken = $turn == 0 ? player0_move($coins) : player1_move($coins);
    $player{"$turn"} += $taken;
    say "player $turn takes:";
    say "\t$taken";
    say "\t\tplayer total : $player{$turn} ";
    say '';

    ## toggle the turn bit
    $turn ^= 1;
}

say "player 0 : $player{0}";
say "player 1 : $player{1}";

sub shuffle {
    my @input = @_;
    my @output;
    while (scalar @input) {
        my $idx = int rand (scalar @input);
        push @output, splice(@input, $idx, 1);
    }
    return @output;
}

sub player0_move {
## apply the winning algorithm to the line
## return the coin taken
    my $coins  = shift @_;
    my $length = scalar $coins->@* - 1;

    ## target_index will always be defined as target is largest value coin in the line
    my $target = find_target( $coins );
    my ($target_index) = grep { $coins->[$_] == $target } (0..$length);

    my $left  = $target_index;
    my $right = $length - $target_index;

    if ($right == 0) {
        return pop $coins->@*;
    }
    elsif ($left == 0 or $left > $right) {
        return shift $coins->@*;
    }
    else {
        return pop $coins->@*;
    }
}

sub player1_move {
## remove the largest coin from the the ends of the line
    my $coins  = shift @_;
    return $coins->[0] > $coins->[scalar $coins->@* - 1] ? shift $coins->@* : pop $coins->@*;
}

sub find_target {
## determines the highest value coin left in the line and returns the value
## without altering the coin list
    my $coins = shift;
    my @sorted = sort {$b <=> $a} $coins->@*;
    return $sorted[0];
}

## included as a bonus, works just fine
sub find_target2 { return +( sort {$b <=> $a} $_[0]->@* )[0] }
