#! /opt/local/bin/perl
#
#       nim-con-one.pl
#
#         TASK #2 › NIM Game
#         Submitted by: Mohammad S Anwar
#         Write a script to simulate the NIM Game.
# 
#         It is played between 2 players. For the purpose of this task, let
#         assume you play against the machine.
# 
#         There are 3 simple rules to follow:
# 
#         a) You have 12 tokens
#         b) Each player can pick 1, 2 or 3 tokens at a time
#         c) The player who picks the last token wins the game
#
#       analysis:
#         I had a feeling I could just look this one up, but as often decided to
#         mull it over on my own as I was working on reviews and such. One night
#         while falling asleep I worked everything through.
# 
#         I suspected that with enough tokens, the small range allowed in moves
#         would be amplified enough to produce complex behavior in the gameplay.
#         Perhaps without such technical working I was expected to think this,
#         as the facts prove otherwise.
# 
#         It's a set-up. A con. Whoever moves first, if the role is played
#         right, will win. Every time. And the gameplay to win can be reduced to
#         a few easily stated rules.
#                 
#       gameplay:
#         Lets call the two players You and your Opponent.
# 
#         Let's walk winning backwards from the end: your Opponent draws one
#         token, and loses. The pot at that point holds one token; any other
#         number and the Opponent would draw one or more and  not lose. The turn
#         before, the pot must therefore contain 2-4 tokens, so You can draw 1-3
#         and leave your Opponent with 1.
# 
#         For this to happen, you must make it so in the previous move your
#         Opponent has 5 tokens. If that is so no matter the move made, You will
#         be left with the required 2-4 tokens to win.
# 
#         Regressing an additional step, to leave your opponent with 5 tokens
#         you must have between 6-8 tokens, and to ensure that in the previous
#         step your opponent must have 9 tokens.
# 
#         When starting from 12 take 3 tokens, leaving your opponent with 9. You
#         will then always be able to win. At every move make sure your opponent
#         is left with either 1, 5, or 9 tokens, which is always possible when
#         taking the first move from 12 tokens. 
#         
#       method: 
#         A $pot variable is established, which is reduced as draws are made
#         against it. The computer plays a perfect strategy, which involves
#         determining a target value for the pot to be delivered to the
#         opponent. The target is the largest multiple of 4 with 1 added taht is
#         less than or equal to the pot. The draw is the pot minus the target.
#         If the draw is 0, a random number between 1 and 3 tokens is drawn.
#         This last behavior is arbitrary, as there is no good move. However a
#         random draw will avoid the repetion of a 1 draw; the in fusion of
#         randomness will help to keep the player from guessing a winning
#         strategy.

#       the con:
#         There is a list of fatal token quantities that, when a player recieves
#         a pot containing that many tokens, the player has lost. The objective
#         is to deliver one's opponent a quantity from that list.
# 
#         The list is all multiples of 4, plus 1: 1,5,9,13,17,21...
#         
#         If the game is played with a quantity of tokens from this list, the
#         first player will lose. Any other quantity, and the first player will
#         win. So the con is to play with a 'random' number of tokens. If the
#         quantity is from the list, insist the other player draw first that
#         turn "to be fair". Careful play can always redirect the opponent into
#         a losing position, so unless the opponent also plays perfectly,
#         advantage can be wrested at any point before the end.
# 
#         If the opponent understands the perfect strategy, it's unlikely they
#         will agree to play.
# 
#         
# 
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";
use Lingua::EN::Inflexion;


my $pot = 12;

my $now = '';

while (-scam) {
    
    ## player draw phase
    my $request = 
        $pot > 2 ? "1, 2 or 3 tokens."
                 : $pot > 1 ? "1 or 2 tokens."
                            : "the token.";

    say inflect(
        "<#d:$pot>There <V:is>$now $pot <N:token> on the pot. Please draw $request"
    );
    my $draw = <STDIN>;
    if ($draw !~ /^[123]$/ or $draw > $pot) {
        say "Please take $request";
        $now = '';
        redo;
    }
    
    say inflect(
        "You drew <#wnc:$draw> <N:token>."
    );
    
    $pot -= $draw;
    if ( $pot < 1 ) {
        say "Player loses.";
        exit;
    }
    
    
    ## computer draw phase
    $now = " now";
    
    say inflect(
        "<#d:$pot>
        There <V:is>$now $pot <N:token> in the pot. Computer will draw next."
    );

    my $target = int(($pot-1)/4) * 4 + 1;           
    
    $draw = $pot - $target;
    $draw ||= int rand(3) + 1;
    $draw = 1 if $draw > $pot;
    
    say inflect( 
        "Computer draws <#wnc:$draw> <N:token>."
    );
    
    $pot -= $draw;
    if ( $pot < 1 ) {
        say "Computer loses.";
        exit;
    }

}













# use Test::More;
# 
# is 
# 
# done_testing();
