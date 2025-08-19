#!/usr/bin/env perl
# Perl weekly challenge 335
# Task 2:  Find Winner
#
# See https://wlmb.github.io/2025/08/18/PWC335/#task-2-find-winner
use v5.36;
use feature qw(try);
use PDL;
die <<~"FIN" unless @ARGV;
    Usage: $0 G1 G2...
    to find the winner in the tic tac toe game Gi.
    Each game is a string with the format
    "[[X0 Y0][X1 Y1]...]"
    where Xi Yi are the coordinates of the ith move, in the range 0..2.
    Even numbered moves correspond to player A and odd to player B.
    FIN
my @players=map {"Player $_"}  qw(A B);
my $result;
for(@ARGV){
    try {
	my $moves=pdl($_);
	die "Wrong shape. Expected array of 2D vectors: $_"
	    unless $moves->dim(0)==2;  # each move should be 2D vector
	die "Wrong move. Expected 0<=coordinate<=2: $_"
	    unless 0 <= $moves->min && $moves->max <= 2;
	die "Repeated moves are invalid: $_"
	    unless $moves->uniqvec->dim(1)==$moves->dim(1);
	my $length=$moves->dim(1);   # length of game
	my $last=1-$length%2;        # last player
	$result = "Pending", next if $length < 5; # game was too short
	$result = $players[$last], next if
	    win(
		$moves->slice(":,$last:-2:2")   # previous moves of last player
		-$moves->slice(":,-1")       # with respect to last move
	    );
	$result = "Draw", next
	    if $moves->dim(1)==9;   # finished game without a winner
	$result= "Pending";         # unfinished game
    } catch($e) {
	say $e;
	undef $result;
    }
} continue{
    say "$_ -> $result" if defined $result;
}
sub win($relative){ # moves by one player relative to last
    my $length=$relative->dim(1);
    return (($relative->slice("(0)")*$relative->slice("(1),*")
	     - $relative->slice("(1)")*$relative->slice("(0),*")) # compute determinants
	    ==0)->sum  # count zeroes
	> $length;     # win if larger than the trivial number
}
