#!/usr/bin/perl
# 
# Task 2: "Unique Subsequence
# 
# You are given two strings $S and $T.
# 
# Write a script to find out count of different unique subsequences
# in $S matching $T without changing the position of characters.  UPDATE:
# 2021-02-08 09:00AM (UK TIME) suggested by Jonas Berlin, missing entry [5].
# 
# Example 1:
#   Input: $S = "littleit', $T = 'lit'
#   Output: 5
#   
#       1: [lit] tleit
#       2: [li] t [t] leit
#       3: [li] ttlei [t]
#       4: litt [l] e [it]
#       5: [l] ittle [it]
#   
# Example 2:
#   Input: $S = "london', $T = 'lon'
#   Output: 3
# 
#     1: [lon] don
#     2: [lo] ndo [n]
#     3: [l] ond [on]
# "
# 
# My notes: nice question.  Of course one could do this by translating $T
# into a Task-1-style pattern, so lit becomes *l*i*t* and figuring out
# how many different ways that pattern can apply.  But as $T has no meta-chars,
# an easier approach may be possible:
#  - locate all positions in $S where head($T) appears, for each of them
#    recursively match subtr($S,pos+1) against tail($T))
# However, if we want to produce the "[lo] ndo [n]" explanation of each match,
# that's slightly trickier to code.  Suppose we represent a specific match
# by a "match tag" like "..ndo.", representing the explanation "[lo] ndo [n]".
# it's easy enough to produce the match tags while counting matches, and easy
# enough to convert match tag "..ndo." (and t="lon") into "[lo] ndo [n]" after.
# NB: Also added test suite [invoke with --test]
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use Data::Dumper;

my $debug=0;
my $test=0;
die "Usage: unique-subsequnces [--test] [--debug]\n".
    "Or...  unique-subsequnces [--debug] S T\n"
	unless GetOptions( "debug" => \$debug, "test" => \$test )
	    && ($test && @ARGV==0 || !$test && @ARGV==2);

if( $test )
{
	dotests();
	exit 0;
}

my( $s, $t ) = @ARGV;
my @match = find_the_ways( $s, $t );
my $nways = @match;
say "Input: s=$s, t=$t";
say "Output: $nways";
foreach my $mn (0..$#match)
{
	say( '    ' . ($mn+1) . ': ' . explain_matchtag($t,$match[$mn]) );
}

#
# my @match = find_the_ways( $s, $t );
#	Find all different ways that $s can contain the chars in $t
#	in that order.  For each way that we find, generate a match tag, a
#	string like $s, but in which every position in the tag that matches a
#	char in $t replaced with a '.'.
#	Return a list of all different completed matchtags.
#
fun find_the_ways( $s, $t )
{
	return consider_her_ways( $s, 0, $t, $s );
}



#
# my @match = consider_her_ways( $s, $spos, $t, $matchtag );
#	Find all different ways that $s (starting at pos $spos)
#	contains the chars in $t in that order; $matchtag is the "match tag"
#	so far, this starts as a copy of $s, in which every previously matched
#	char from $t has been replaced with a '.'.
#	Return a list of all different completed matchtags.
#
fun consider_her_ways( $s, $spos, $t, $matchtag )
{
	return ( $matchtag ) if $t eq '';
	my $firstlet = substr($t,0,1);
	my $t2 = substr($t,1);
	my $call = "ctw( $s, $t, let:$firstlet, spos:$spos, mt:$matchtag )";
	my @pos = grep { substr($s,$_,1) eq $firstlet } $spos..length($s)-1;
	say "$call: pos of $firstlet = ".join(',',@pos) if $debug;
	my @result;
	foreach my $pos (@pos)
	{
		say "$call: trying pos $pos" if $debug;
		my $m2 = $matchtag;
		substr($m2,$pos,1,'.');
		say "$call: new matchtag=$m2" if $debug;
		my $sp2 = $pos+1;
		my @m = consider_her_ways( $s, $sp2, $t2, $m2 );
		#say "$call: returned from try pos $pos, sp2=$sp2, ways ".join(',',@m)
		#	if $debug;
		#say "$call: adding to result" if $debug;
		push @result, @m;
	}
	say "$call: returning ". join(',',@result) if $debug;
	return @result;
}


#
# my $s = explain_matchtag($t,$tag);
#	Given a $t str like "lon", and a match tag like "..ndo.",
#	build a pretty explanation string "[lon] ndo [n]".
#
fun explain_matchtag( $t, $tag )
{
	my @let = split(//,$t);	# split t into letters eg 'l', 'o', 'n'..
	my $result = $tag;
	foreach my $letter (@let)
	{
		$result =~ s/\./[$letter]/;
	}
	$result =~ s/\]\[//g;	# collapse multiple [a][b][c] to [abc]
	$result =~ s/\]/] /g;	# add a space after every ]
	$result =~ s/\[/ [/g;	# add a space before every [
	$result =~ s/^\s+//;	# ok, that added spaces at start and end;
	$result =~ s/\s+$//;	# remove them..
	return $result;
}


#
# dotests();
#	Do a load of tests.
#
fun dotests()
{
	eval "use Test::More"; die $@ if $@;

# format of each test: F:s:t:mt1,mt2.. or E:tag:t:explanation
my @tests = (
	"F:london:lon:...don,..ndo.,.ond..",
	"E:...don:lon:[lon] don",
	"E:..ndo.:lon:[lo] ndo [n]",
	"E:.ond..:lon:[l] ond [on]",
	"F:littleit:lit:...tleit,..t.leit,..ttlei.,.ittle..,litt.e..",
	"E:...tleit:lit:[lit] tleit",
);

	say "dotests() entry" if $debug;
	say "dotests(): tests=". Dumper(\@tests) if $debug;
	foreach my $test (@tests)
	{
		say "test $test" if $debug;
		my( $type, $rest ) = split( /:/, $test, 2 );
		if( $type eq "F" )
		{
			my( $s, $t, $mts ) = split( /:/, $rest );
			my @m = split(/,/, $mts);
			my $nmatches = @m;

			my @found = find_the_ways( $s, $t );
			my $nfound = @found;

			my $fin = "ctw($s,$t)";
			is( $nmatches, $nfound, "$fin: matches = $nmatches" );
			foreach my $pos (0..$nfound-1)
			{
				is( $found[$pos], $m[$pos],
					"$fin: match(pos)=$m[$pos]" );
			}
		} elsif( $type eq "E" )
		{
			my( $tag, $t, $explanation ) = split( /:/, $rest );
			my $got = explain_matchtag($t,$tag);
			is( $got, $explanation, "explanation(tag=$tag,t=$t)=$explanation" );
		}
	}
	done_testing();
	say "dotests() exit" if $debug;
}
