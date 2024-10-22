#!/usr/bin/env perl
# Perl weekly challenge 292
# Task 2:  Zuma Game
#
# See https://wlmb.github.io/2024/10/21/PWC292/#task-2-zuma-game
use v5.36;
use Memoize;
die <<~"FIN" unless @ARGV==2;
    $0 board hand
    to play the Zuma Game. The board and hand are string where each
    letter represents a color. Outputs the minimum number of steps
    to clear the board or -1 if it is not possible
    FIN
my ($board, $hand) = @ARGV;
memoize "play";
say "@ARGV -> ", play($board, $hand);

sub play($board, $hand){
    my $length = length $hand;
    my $result = -1;
    return 0 if $board eq "";                       # Nothing to do if the board is already clear
    return -1 if $length == 0;                      # Failure if no more balls
    for(0 .. $length-1){                            # choose a ball
        my $newhand = $hand;
        my $ball=substr $newhand, $_, 1, "";        # remove it from the hand
        for(0 .. length $board){                    # choose a position in the board
            my $newboard = $board;
            substr $newboard, $_, 0, $ball;         # add the ball to the board
            1 while $newboard =~ s/(.)\1\1\1*//;    # remove groups of 3+ balls
            my $next = play($newboard, $newhand);   # recurse
            $result = $next + 1 if $next != -1 &&
                ($result == -1 || $next < $result); # update current result
        }
    }
    return $result;
}
