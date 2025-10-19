#!/usr/bin/env perl
# Perl weekly challenge 343
# Task 2:  Champion Team
#
# See https://wlmb.github.io/2025/10/18/PWC343/#task-2-champion-team
use v5.36;
use feature qw(try);
use PDL;
die <<~"FIN" unless @ARGV;
    Usage: $0 M0 M1...
    to find the champion team given the strength matrix Mn.
    The j-th entry of the i-th row of Mn is 1 if team i beats team j.
    Otherwise it is a zero. Each Mn is a string of the form
    "[[m00 m01...][m10 m11...]...]" where mij is 0 or 1.
    The value of mii is ignored.
    FIN
for(@ARGV){
    try {
        my $work=(my $input=pdl($_))->copy;
        $work->diagonal(0,1).=1;                # For the case of no tie
        die "Only zeroes and ones are allowed" unless all(($work==0)|($work==1));
        my $sum=$work->sumover;                 # Relative strength of teams
        my $losers=which($sum!=$sum->maxover);  # Teams that cannot win
        if(!$losers->isempty){                  # Remove losers from further consideration.
            $work->dice($losers).=0;            # Columns
            $work->dice("X",$losers).=0;        # and rows
        }
        $sum=$work->sumover;                    # recompute with possible winners only
        my $winners=which($sum==$sum->maxover); # teams that can win
        say "$input -> ", $winners->squeeze;    # scalar for single winner
    }
    catch($e){
        warn $e;
    }
}
