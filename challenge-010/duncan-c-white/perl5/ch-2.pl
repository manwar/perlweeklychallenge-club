#!/usr/bin/perl

# Challenge 2: "Write a to find Jaro-Winkler distance between two strings."
# 
# My notes:
# 
# WTF is Jaro-Winkler, read wikipedia page, well Jaro-Winkler is a simple prefix
# adjustment to the Jaro distance, but the wikipedia page explaining Jaro distances
# is not very clear - it describes it in terms of matched characters and transposed
# characters, but it's description of matching within a range, and of how to count
# transposed characters is almost completely unclear.  I couldn't write code based
# on such a poor description!
# 
# But googling further, Rosetta Stone had various implementations in various languages
# (including C and Perl), which clarifies the terribly unclear wikipedia entry.
# Matching involves the same char at pos i in str1, and somewhere within match_distance
# of pos i in str2.  All matched characters are marked.
#
# Transpositions are a second phase, looking at all matched characters - if the next
# pair of matched characters in str1 and str2 are different, that's a transposition.
# 
# Ok, I basically understand it now.  Transposed characters are matched characters
# in different positions, eg TH vs HT


use strict;
use warnings;
use Function::Parameters;
use Data::Dumper;
use List::Util qw(min max);


#
# my $m = matches( $w1, $w2, $l1, $l2, $match_distance, $m1, $m2 );
#	Compute $m, the number of exact matches within $w1 and $w2 (of
#	lengths $l1 and $l2), within $match_distance positions of each other,
#	and build up @$m1 and @$m2, arrays of matched positions in both strings.
#
fun matches( $w1, $w2, $l1, $l2, $match_distance, $m1, $m2 )
{
	# number of matches
	my $m = 0.0;

	# look throughout $w1 at every position $i
	for( my $i = 0; $i < $l1; $i++)
	{
		# start and end take into account the match distance
		my $start = max(0, $i - $match_distance);
		my $end = min($i + $match_distance + 1, $l2);

		# forevery possible matching pos k in w2
		for( my $k = $start; $k < $end; $k++)
		{
			# find first str2[k] not matched
			next if $m2->[$k];

			# where w[i] eq w2[k]
			if( substr($w1,$i,1) eq substr($w2,$k,1) )
			{
				# found a match
				$m1->[$i] = 1;
				$m2->[$k] = 1;
				$m++;
				last;
			}
		}
	}

	return $m;
}


#
# my $t = transpositions( $w1, $w2, $l1, $l2, $m1, $m2 );
#	Compute $t, the number of matches transpositions within $w1 and $w2 (of
#	lengths $l1 and $l2), using @$m1 and @$m2, arrays of matched positions in
#	both strings.
#
fun transpositions( $w1, $w2, $l1, $l2, $m1, $m2 )
{
	my $t = 0.0;

	my $k = 0;
	# foreach matched position i in w1
	for( my $i = 0; $i < $l1; $i++)
	{
		next unless $m1->[$i];

		# find next matched position in w2
		$k++ while !$m2->[$k];

		# increment t if chars different
		$t++ if substr( $w1,$i,1) ne substr($w2,$k,1);

		$k++;
	}

	# divide the number of t by two as per the algorithm specs
	return ($t/2);
}


#
# my $jsim = jaro_sim($str1, $str2);
#	Plain Jaro similarity of $str1 and $str2.
#
fun jaro_sim( $str1, $str2 )
{
	# matching should happen as follows, building m1[] and m2[]

	my $l1 = length($str1);
	my $l2 = length($str2);
  
	# if both strings are empty return 1
	# if only one of the strings is empty return 0
	if( $l1 == 0 )
	{
		return $l2 == 0 ? 1.0 : 0.0;
	}
  
	# max distance between two chars to be considered matching
	my $match_distance = int( max($l1, $l2) / 2 ) - 1;

	my @m1;
	my @m2;
	my $m = matches( $str1, $str2, $l1, $l2, $match_distance, \@m1, \@m2 );
	my $t = transpositions( $str1, $str2, $l1, $l2, \@m1, \@m2 );

	# return the Jaro similarity
	my $s = (($m / $l1) + ($m / $l2) + (($m - $t) / $m)) / 3.0;
	#printf( "s1=$str1, s2=$str2, l1=$l1, l2=$l2, match_distance=$match_distance, m=%f, t=%f\n",
	#	$m, $t );
	return $s;
}


#
# my $jdist = jaro_dist($str1, $str2);
#	Jaro distance between $str1 and $str2.
#
fun jaro_dist( $str1, $str2 )
{
	my $jsim = jaro_sim( $str1, $str2 );
	printf( "jsim=%f\n", $jsim );
	return 1.0 - $jsim;
}


#
# my $jwsim = jarowinkler_sim($str1, $str2);
#	Jaro-Winkler similarity of $str1 and $str2,
#
fun jarowinkler_sim( $str1, $str2 )
{
	my $jsim = jaro_sim( $str1, $str2 );
	my $prefixlen=0;
	my $i=0;
	while( substr($str1,$i,1) eq substr($str2,$i,1) )
	{
		$prefixlen++;
		$i++;
	}
	$prefixlen = min(4,$prefixlen);
	#print "prefixlen=$prefixlen\n";
	my $p = 0.1;
	return $jsim - $prefixlen*$p*(1.0-$jsim);
}


#
# my $jwdist = jarowinkler_dist($str1, $str2);
#	Jaro-Winkler distance between $str1 and $str2.
#
fun jarowinkler_dist( $str1, $str2 )
{
	my $jwsim = jarowinkler_sim( $str1, $str2 );
	#printf( "jwsim=%f\n", $jwsim );
	return 1.0 - $jwsim;
}


die "Usage: jaro-winkler-dist ALL | jaro-winkler-dist WORD1 WORD2\n"
	unless (@ARGV==1 && $ARGV[0] eq "ALL") || @ARGV==2;
my $w1 = shift;
if( $w1 ne "ALL" )
{
	my $w2 = shift;
	my $jdist = jarowinkler_dist($w1, $w2);
	printf( "jarowinkler-dist($w1,$w2) = %.6f\n", $jdist );
}
else
{
	my @data = (
		[ "CRATE",    "TRACE" ],
		[ "MARTHA",    "MARHTA" ],
		[ "DIXON",     "DICKSONX" ],
		[ "JELLYFISH", "SMELLYFISH" ],
	);
	foreach my $pair (@data)
	{
		my( $w1, $w2 ) = @$pair;
		printf("jdiff($w1,$w2)=%.6f\n", jarowinkler_dist($w1,$w2));
	}
}
