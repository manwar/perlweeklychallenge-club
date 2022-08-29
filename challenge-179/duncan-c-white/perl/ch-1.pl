#!/usr/bin/perl
# 
# Task 1: Ordinal Number Spelling
# 
# You are given a positive number, $n.
# Write a script to spell the ordinal number.
# 
# For example,
# 
# 11 => eleventh
# 62 => sixty-second
# 99 => ninety-ninth
# 
# MY NOTES: ok, sounds pretty easy for n>0; let's arbitrarily deal with
# n < 1000000 (although millions, billions etc would be pretty easy to add).
# Let's do this via formwords(n) which converts (eg) n=17 to "seventeen" and
# then use that to generate the final "seventeeth" by mucking about with the
# ending (and using some special case rules for English, eg one->first)
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-1.pl
# into C (look in the C directory for that).
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use Data::Dumper;


my $debug=0;
die "Usage: nth [--debug] N\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==1;


# rules to deal with "formwords"..

my @oneto19 = qw(one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen);
my @tens = qw(twenty thirty forty fifty sixty seventy eighty ninety);


#
# my $count = formwords( $n );
#	Generate and return the English form of $n,
#	eg if n=17, return "seventeen".
#
fun formwords( $n )
{
	die "formwords: n ($n) must be > 0\n" if $n<1;

	my $count = inner_formwords( $n );

	# let's have no more than one "-and-"..
	$count =~ s/and-// while $count =~ /-and-.*-and-/;

	return $count;
}


#
# my $count = inner_formwords( $n );
#	Generate and return the English form of $n,
#	eg if n=17, return "seventeen".
#
fun inner_formwords( $n )
{
	die "formwords: n ($n) must be > 0\n" if $n<1;
	return $oneto19[$n-1] if $n<20;
	if( $n < 100 )
	{
		my $tens = $tens[int($n/10)-2];
		say "debug: n=$n, tens=$tens" if $debug;
		if( $n % 10 == 0 )
		{
			return $tens;
		}
		my $units = $oneto19[$n%10-1];
		return "$tens-$units";
	}
	if( $n < 1000 )
	{
		my $mod = $n%100;
		$n = int($n/100);
		my $hundreds = $oneto19[$n-1];
		return "$hundreds-hundred" if $mod==0;
		my $fw = inner_formwords($mod);
		return "$hundreds-hundred-and-$fw";
	}
	if( $n < 1000000 )
	{
		my $mod = $n%1000;
		$n = int($n/1000);
		my $thousands = inner_formwords($n);
		my $result = "$thousands-thousand";
		return $result if $mod==0;

		$result .= "-and-". inner_formwords($mod);
		return $result;
	}
	return "$n >= 1000000 to do";
}


my %special = qw(one first two second three third five fifth
		 eight eighth twelve twelfth);

#
# my $nth = nth( $n );
#	Generate and return the "nth" English form of $n,
#	eg if n=17, return "seventeenth".  Do it using formwords()
#	and then mucking about with the ending..
#
fun nth( $n )
{
	my $fw = formwords( $n );

	my( $prefix, $lastbit );
	if( $fw =~ /^(.+)-([^-]+)$/ )
	{
		$prefix = $1;
		$lastbit = $2;
	} else
	{
		$prefix = "";
		$lastbit = $fw;
	}

	if( defined $special{$lastbit} )
	{
		$lastbit = $special{$lastbit};
	}
	else
	{
		$lastbit =~ s/y$/ie/;
		$lastbit .= "th";
	}

	if( $prefix )
	{
		return "$prefix-$lastbit";
	} else
	{
		return $lastbit;
	}
}



my $n = shift;
die "nth: n ($n) must be > 0 and < 1,000,000\n" if $n<=0 || $n>1000000;

#my $count = formwords( $n );
#say $count;
my $nth = nth($n);
say $nth;
