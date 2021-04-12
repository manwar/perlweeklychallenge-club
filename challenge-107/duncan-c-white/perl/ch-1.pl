#!/usr/bin/perl
# 
# Task 1: "Self-descriptive Numbers
# 
# Write a script to display the first three self-descriptive numbers. As
# per wikipedia, the definition of Self-descriptive Number is
# 
#     In mathematics, a self-descriptive number is an integer m that in a
#     given base b is b digits long in which each digit d at position n (the
#     most significant digit being at position 0 and the least significant
#     at position b-1) counts how many instances of digit n are in m.
# 
# For example:
# 
#  1210 is a four-digit self-descriptive number:
# 
#     position 0 has value 1 i.e. there is only one 0 in the number
#     position 1 has value 2 i.e. there are two 1 in the number
#     position 2 has value 1 i.e. there is only one 2 in the number
#     position 3 has value 0 i.e. there is no 3 in the number
# 
# Output
# 
#     1210, 2020, 21200
# 
# WARNING: I realised just before the launch this task was also part of week
# 43, contributed by Laurent Rosenfeld. It is too late to change now. Feel
# free to share your previous solutions if you took part in the week 43
# already. I should have been more careful, sorry.
# "
# 
# My notes: well, as it happened I skipped task 43, so let's have a go.  The
# important thing is: number of digits == base, which puts extra constraints
# on the digits.  So try bases b = 2.. try all base b numbers for "self-
# descriptiveness" and then and stop after finding the first N self-descriptive
# numbers.  Let's take N as a command line input for generality, default 3.
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use Data::Dumper;

my $debug=0;
die "Usage: selfdescriptive [--debug] [N]\n"
	unless GetOptions( "debug" => \$debug ) && @ARGV<2;

my $n = shift // 3;

# find first $n self-descriptive numbers

my $found = 0;

#
# my $issd = selfdescriptive($digitseq);
#	Determine whether the given digit sequence is
#	a self descriptive number; return 1 for yes, 0 for no.
#
fun selfdescriptive( $digitseq )
{
	my @occ = (0) x length($digitseq);
	# compute number of occurences of digit (index)
	foreach my $dig (split(//,$digitseq))
	{
		$occ[$dig]++;
	}
	#die "ds=$digitseq, occ=", Dumper \@occ;

	for( my $pos = length($digitseq)-1; $pos>=0; $pos-- )
	{
		my $dig = substr($digitseq,$pos,1);
		return 0 unless $occ[$pos] == $dig;
	}

	return 1;
}



#
# my $iplus1 = inc_base_overflow( $n, $b );
#	Increment digit sequence $n in base $b.
#	Return "" if $d+1 overflows the current number of digits
#
fun inc_base_overflow( $n, $b )
{
	my $l = length($n);
	for( my $pos = $l-1; $pos>=0; $pos-- )
	{
		my $dig = substr($n,$pos,1);
		if( $dig < $b-1 )
		{
			$dig++;
			substr($n,$pos,1) = $dig;
			return $n;
		}
		substr($n,$pos,1) = "0";
	}
	return "";
}


for( my $b = 2; $found < $n; $b++ )
{
	my $i = "0" x $b;
	for(;;)
	{
		if( selfdescriptive($i) )
		{
			say $i;
			last if ++$found == $n;
		}
		#say "$i";

		# now increment digitseq $i in base $b
		$i = inc_base_overflow( $i, $b );
		last if $i eq "";
	}
}
