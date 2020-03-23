#!/usr/bin/perl
#
# Task #2: "Lucky Winner
#
# Suppose the following coins are arranged in a line, but in
# a different random order each game:
# 
#     £1, 50p, 1p, 10p, 5p, 20p, £2, 2p
# 
# A human is playing against the computer. Pick a random player to go
# first, after that players play alternative moves.  Each move, either pick
# the FIRST coin or the LAST coin.  The winner is the player with the greatest
# amount of money.  Write a program to play the whole game, with a computer
# move choice method with the greatest choice of winning.
# "
# 
# My notes: umm.. with the original wording, it wasn't very clear what exactly
# we're being asked to do, so I've changed the wording above to clarify what
# I think was meant.
# Given those coin values, whoever picks up the £2 coin will win.  obviously
# if the £2 coin is initially at one end,. picking it immediately is the
# correct move, otherwise both players should ensure they do not give the
# other player the opportunity to pick the £2 coin next move.  ie. avoid
# leaving the £2 coin at either end..
# In practice: the first player alway wins, so rather a dull game.
# If playing second, the best the computer can do is pounce on a human
# mistake.
#

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Data::Dumper;
use List::Util qw(max);

my @coins = ( 100, 50, 1, 10, 5, 20, 200, 2 );

my $biggest = max(@coins);

srand( $$ ^ time() );

# randomise their order..
@coins = sort { int rand(3) - 1 } @coins;

#die Dumper \@coins;

#
# my $choice = pick_first_or_last( @coins );
#	Given an array of coin values @coins (expressed in pennies),
#	pick either the "first" coin (return 'first') or the "last" coin
#	(return 'last'), depending on which is a better move to make.
#	
#	The $biggest coin (with these coins the £2 coin) is critical: pick
#	it if it's at either end, otherwise prevent it from getting to either
#	end..  if it's already been picked, calculate the biggest remaining
#	and apply the same strategy to that value..
#
fun pick_first_or_last( @coins )
{
	my $firstc = $coins[0];
	return 'first' if $firstc == $biggest;
	my $lastc  = $coins[$#coins];
	return 'last' if $lastc == $biggest;

	# find position of biggest (if it's still here)
	my @bigpos = grep { $coins[$_] == $biggest } 0..$#coins;
	# if not here.. change biggest to the biggest that is still here
	if( @bigpos == 0 )
	{
		$biggest = max(@coins);
		# find the position of that new biggest
		@bigpos = grep { $coins[$_] == $biggest } 0..$#coins;
	}
	# now: @bigpos==1, $bigpos[0] is the position of that biggest.
	my $nbp = @bigpos;
	die "logic error, bigpos array has $nbp elements, should be 1\n"
		unless $nbp==1;
	my $bigpos = shift @bigpos;

	return 'last' if $bigpos == 1;		# biggest very close to front
	return 'first' if $bigpos == $#coins-1;	# biggest very close to back

	# pick bigger
	return 'last' if $coins[$#coins] > $coins[0];
	return 'first';
}

my $humtot = 0;
my $comptot = 0;

# randomise who plays first
my $player = int(rand(2));	# 0 is human, 1 is computer
my @who = qw(You I);

say "$who[$player] play first";

while( @coins )
{
	say "coins: ", join(',',@coins);
	if( $player == 0 )
	{
		my $choice = 'f';
		if( @coins > 1 )
		{
			print " pick first coin (f) or last coin (l)? ";
			$choice = <STDIN>;
			chomp $choice;
			$choice = lc($choice);
		}

		my $coin = ($choice eq 'f')? shift @coins : pop @coins;
		$humtot += $coin;
		say " you picked $coin, your total is now $humtot";
	} else
	{
		my $choice = pick_first_or_last( @coins );
		say " I pick $choice coin";

		my $coin = ($choice eq 'first')? shift @coins : pop @coins;
		$comptot += $coin;
		say " I picked $coin, my total is now $comptot";
	}

	# switch players
	$player = 1-$player;
}

say "you scored $humtot, I scored $comptot";
if( $humtot > $comptot )
{
	say "well done, you win";
} elsif( $humtot < $comptot )
{
	say "yippee, I win";
} else
{
	say "it's a draw!";
}
