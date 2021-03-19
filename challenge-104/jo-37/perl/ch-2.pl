#!/usr/bin/perl -s

use v5.16;
use warnings;
use experimental 'signatures';

our ($help, $num, $turn, $misere);
$misere = !!$misere; 

die <<EOS if $help;
usage: $0 [-help] [-num=N] [-turn] [-misere]

-help
    print this help text

-num=N
    start the game with N tokens (default: 12)

-turn
    the machine takes the first turn

-misere
    misère version: the player taking the last token loses the game.

EOS

# In this simplified version of the NIM game the party facing a pile of
# 4 tokens will lose the game as they are forced to leave a number of
# tokens that can be taken away in a single move.  The same
# consideration applies to all multiples of 4 tokens.
# Analogously, 4*n+1 tokens constitute a losing position in the misère
# version of the game.
# Strategy: Choose a random move in a losing position or make the
# winning move otherwise.

my $tokens = $num || 12;

while ($tokens > $misere) {
    say token($tokens);
    my $move;
    if (++$turn % 2) {
        once: {
            say 'How many?';
            say('Invalid amount.'), redo if ($move = <STDIN>) !~ /^[123]$/;
            say(token($tokens, 1)), redo if $move > $tokens;
        }
    } else {
        $move = ($tokens - $misere) % 4 || 1 + int rand 3;
        say "I take $move.";
    }
    $tokens -= $move;
}
say 'The last token is ', qw(mine. yours.)[($turn + $tokens) % 2];
say qw(I You)[($turn + $tokens + $misere) % 2], ' win.';

sub token ($n, $r=0) {
    my @p = $n > 1 ? ('are', 's') : ('is', '');
    splice @p, 1, 0, ' only' x $r, $n;
    splice @p, 4, 0, ' remaining' x $r;

    sprintf "There %s%s %d token%s%s.", @p;
}
