#!/usr/bin/perl
#
# Task 1: "Survivor
#
# There are 50 people standing in a circle in position 1 to 50. The person
# standing at position 1 has a sword. He kills the next person i.e. standing
# at position 2 and pass on the sword to the immediate next i.e. person
# standing at position 3. Now the person at position 3 does the same and
# it goes on until only one survives.
# 
# Write a script to find out the survivor.
# "
# 
# My notes: cute, sounds easy.  Let's investigate this for N=1..max
# 

use feature 'say';
use strict;
use warnings;
use Function::Parameters;
use Getopt::Long;
#use Data::Dumper;

my $debug = 0;
my $tabulate = 0;
my $result = GetOptions( "tabulate" => \$tabulate, "debug" => \$debug );
die "Usage: survivor [--debug] [--tabulate] [MAX]\n" if $result && @ARGV>1;
my $max = shift // 50;

if( $tabulate )
{
	foreach my $n (1..$max)
	{
		my $survivor = survivor( $n );
		say "$n people survivor: person $survivor";
	}
}
else
{
	my $survivor = survivor( $max );
	say "$max people survivor: person $survivor";
}


#
# my $survivor = survivor( $n );
#	Do the above survivor algorithm for $n people.
#	Return the person number of the sole survivor.
#
fun survivor( $n )
{
	my @alive = ( 1..$n );		# @alive list of person numbers still alive
	my $pos = 0;			# position in @alive
	my $nalive = $n;		# number of people still alive
	while( $nalive>1 )
	{
		# person at pos $pos kills person next to him
		my $i = $alive[$pos];
		my $nextpos = $pos+1;
		$nextpos = 0 if $nextpos>$#alive;
		my $j = $alive[$nextpos];
		say "person $i at pos $pos kills next person $j" if $debug;
		splice( @alive, $nextpos, 1 );
		$nalive--;
		# hand sword on
		$pos++;
		$pos = 0 if $pos>$#alive;
		my $k = $alive[$pos];
		say "hands sword onto person $k at pos $pos" if $debug;
		say "$nalive people alive: ", join(',',@alive) if $debug;
	}
	say "" if $debug;
	return $alive[0];
}
