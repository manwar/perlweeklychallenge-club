#!/usr/bin/env perl
# Perl weekly challenge 281
# Task 2:  Knight’s Move
#
# See https://wlmb.github.io/2024/08/04/PWC281/#task-2-knight’s-move
use v5.36;
use PDL;
use PDL::NiceSlice;
use experimental qw(for_list);
die <<~"FIN" unless @ARGV && @ARGV%2==0;
    Usage: $0 S1 E1...
    to find how many moves are required for a knight to go from position Si
    to position Ei in a chessboard.
    The positions are given in the format xy where x is a letter in the
    range a-h and denotes the horizontal position while y is a digit between 1 and 8
    and denotes vertical position.
    FIN
my $moves=pdl[[1,2],[2,1]]; # Construct all moves of knight
my $signs=pdl[1,-1];
my $allmoves=pdl($moves, $moves*$signs, -$moves*$signs,-$moves)->clump(1,2);
for my($start, $end)(@ARGV){
    my ($current, $goal)=map{ # convert to coordinate vectors, origin at (0,0)
	warn("Bad format: $_"), next unless /^([a-hA-H])([1-8])$/;
	pdl(ord(lc $1)-ord("a"), $2-1)
    } ($start, $end);
    my $iteration=0;
    my $visited=zeroes(8,8);
    $visited->indexND($current).=1;
    until(($current==$goal)->andover->any){ # until we reach the goal
	my $next=($current+$allmoves->dummy(1))->clump(1,2); # jump to new positions
	$current=$next
	    ->dice_axis(  # remove invalid positions
		 1, which(($next((0))>=0)&($next((0))<8)&($next((1))>=0)&($next((1))<8)))
	    ->uniqvec;     # remove duplicates
	$current=$current->dice_axis( # remove previously visited
		     1, which(!$visited->indexND($current))
	    );
	$visited->indexND($current).=1;
	++$iteration;
    }
    say "From $start to $end -> $iteration movements";
}
