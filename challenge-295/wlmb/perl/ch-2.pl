#!/usr/bin/env perl
# Perl weekly challenge 295
# Task 2:  Jump Game
#
# See https://wlmb.github.io/2024/11/11/PWC295/#task-2-jump-game
use v5.36;
use Memoize;
use List::Util qw(min);
die <<~"FIN" unless @ARGV;
    Usage: $0 N0 N1 ... Nm
    to find the minimum number of jumps to reach Nm starting from N0.
    Ni is the maximum size of jumps from site i.
    FIN
memoize "jump_game";
say "@ARGV -> ",jump_game(@ARGV)//-1;
sub jump_game(@list){
    return 0 if @list<=1; # arrived?
    my $steps;
    for (1..min($list[0], @list-1)){                     # try to jump
        my $current=jump_game(@list[$_..@list-1]);       # and play on remaining list
        if(defined $current){                            # success?
            $steps = 1 + $current unless defined $steps; # initialize required steps
            $steps = min($steps, 1 + $current);          # choose shortest route
        }
    }
    return $steps;
}
