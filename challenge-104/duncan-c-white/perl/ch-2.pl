#!/usr/bin/perl
# 
# Task 2: "NIM Game
# 
# Write a script to simulate the NIM Game.
# 
# It is played between 2 players. For the purpose of this task, let assume
# you play against the machine.
# 
# There are 3 simple rules to follow:
# 
# a) You have 12 tokens
# b) Each player can pick 1, 2 or 3 tokens at a time
# c) The player who picks the last token wins the game
# "
# 
# My notes: damn!  I was really looking forward to this, but THAT'S NOT
# NIM!  That's a similar "simple take away game" as described here:
# https://www.cs.cmu.edu/afs/cs/academic/class/15859-f01/www/notes/comb.pdf
# (although that starts with 21 tokens, not 12).
#
# I've generalised this to take any starting number of tokens, and to let the
# user specify whether each player is human or the computer.  The computer
# plays perfectly - making the single winning move at each stage if it can
# win, otherwise making a random move.
#
# So, for example: if you run
#	./ch-1.pl H C 13
# (human is first player, computer is second player, starting with 13 tokens)
# then the human can win if they take 1 token on the first move, and
# tokens%4 on all subsequent moves.  But if the human takes anything other than
# 1 token on the first move, then the computer will always win.
# 
# Note that you can run the computer against itself, then:
#       ./ch-1.pl C C (any number not divisible by 4)
# means that the first computer player always wins, and
#       ./ch-1.pl C C (any number exactly divisible by 4)
# means that the second computer player always wins.
#

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Getopt::Long;
use Data::Dumper;

my $debug=0;
die "Usage: not-nim [--debug] FirstPlayer:C|H SecondPlayer:C|H [starttokens]\n"
	unless GetOptions( "debug" => \$debug ) &&
	(@ARGV==2 || @ARGV==3);

my $firstplayer = shift;
my $secondplayer = shift;

my $tokens = shift // 12;

my @playfunc = (
	$firstplayer eq 'C' ? \&computer : \&human,
	$secondplayer eq 'C' ? \&computer : \&human,
);

srand( time() ^ $$ );


#
# my $move = human( $p, $tokens );
#	Human player $p makes a single "take away game" move, starting
#	with $tokens.  Return that move - the number of tokens that
#	player $p decides to remove (1, 2 or 3).
#
fun human( $p, $tokens )
{
	for(;;)
	{
		print "player $p: your move.  there are $tokens tokens.  ".
		      "Enter your move (1..3): ";
		my $move = <STDIN>;
		chomp $move;
		return $move if $tokens >= $move && $move >= 1 && $move <= 3;
	}
}


#
# my $move = randmove( $tokens );
#	Make a random move - 1, 2 or 3 (but not making $tokens go negative).
#
fun randmove( $tokens )
{
	return 1 if $tokens == 1;
	return int(rand(2))+1 if $tokens == 2;
	return int(rand(3))+1;
}


#
# my $move = computer( $p, $tokens );
#	Computer player $p makes a single "take away game" move, starting
#	with $tokens.  Return that move - the number of tokens that
#	player $p decides to remove (1, 2 or 3).
#
fun computer( $p, $tokens )
{
	my $mod4 = $tokens % 4;
	my $move = $mod4 == 0 ? randmove($tokens) : $mod4;
	say "player $p (computer) move: there are $tokens tokens.".
	    " remove $move tokens.";
	return $move;
}


#
# my $move = playermove( $p, $tokens );
#	Player $p makes a single "take away game" move, starting
#	with $tokens.  Return that move - the number of tokens that
#	player $p decides to remove (1, 2 or 3).
#
fun playermove( $p, $tokens )
{
	die "playermove: player $p must be 1 or 2\n" unless $p==1 || $p==2;
	return $playfunc[$p-1]->( $p, $tokens );
}



#
# my $winner = playgame( $tokens );
#	Play a whole "take away game" starting with $tokens.
#	Return the winner ("first player" or "second player")
#
fun playgame( $tokens )
{
	for(;;)
	{
		$tokens -= playermove( 1, $tokens );
		return "player 1" if $tokens == 0;

		$tokens -= playermove( 2, $tokens );
		return "player 2" if $tokens == 0;
	}
}


my $winner = playgame( $tokens );
say "The winner is $winner";
