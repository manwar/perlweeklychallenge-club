#!/usr/bin/perl
#
# Task 1: "Pattern Match
# 
# You are given a string $S and a pattern $P.
# 
# Write a script to check if given pattern validate the entire string. Print
# 1 if pass otherwise 0.
# 
# The patterns can also have the following characters:
# ? - Match any single character.
# * - Match any sequence of characters.
# 
# Example 1:
# 	Input: $S = "abcde" $P = "a*e"
# 	Output: 1
# 
# Example 2:
# 	Input: $S = "abcde" $P = "a*d"
# 	Output: 0
# 
# Example 3:
# 	Input: $S = "abcde" $P = "?b*d"
# 	Output: 0
# 
# Example 4:
# 	Input: $S = "abcde" $P = "a*c?e"
# 	Output: 1
# "
# 
# My notes: oh, cool, simpler than regexes, but nice.  Two basic ways of
# doing this: 1). translate it into a regex and use Perl's regex matching,
# 2). figure out a from-scratch mechanism to solve this problem.
# (1) is much simpler, let's do that first: so write a "pat2regex" function.
# Note: I also added a test suite (the above examples) with --test.
# 

use strict;
use warnings;
use Getopt::Long;
use feature 'say';
use Data::Dumper;

my $debug=0;
my $test=0;
die "Usage: pattern-match [--test] [--debug]\n".
    "Or...  pattern-match [--debug] S P\n"
	unless GetOptions( "debug" => \$debug, "test" => \$test )
	    && ($test && @ARGV==0 || !$test && @ARGV==2);
if( $test )
{
	dotests();
	exit 0;
}

my( $s, $p ) = @ARGV;
die "bad patten $p (contains '*'->['?']*->'*' sequence)\n" if
	$p =~ /\*\?*\*/;
my $match = patmatch( $p, $s );
say "Output: $match";


#
# my $match = patmatch( $p, $s );
#	Pattern match $p against $s, returning 1 iff it matches
#	the whole of $s, 0 otherwise.
#
sub patmatch
{
	my( $p, $s ) = @_;
	my $re = pat2regex( $p );
	my $match = ($s =~ /$re/) ? 1 : 0;
	say "patmatch( p:$p, re:$re, s:$s )=$match" if $debug;
	return $match;
}


#
# my $re = pat2regex( $p );
#	Convert the pattern $p to a regex string and return it.
#
sub pat2regex
{
	my( $p ) = @_;
	my $inner = $p;
	$inner =~ s/\*/.*/g;	# * -> .*
	$inner =~ s/\?/./g;	# ? -> .
	return '^'.$inner.'$';
}

#
# dotests();
#	Do a load of tests.
#
sub dotests
{
	eval "use Test::More"; die $@ if $@;

# format of each test: S:P:result
my @tests = (
	"abcde:a*e:1",
	"abcde:ab*e:1",
	"abcde:abc*e:1",
	"abcde:abcd*e:1",
	"abcde:abcde*e:0",
	"abcde:a*d:0",
	"abcde:?b*d:0",
	"abcde:a*c?e:1",
	"hellotherehowareyou:*ll*u:1",	# mine own exemplar..
);

	#say "dotests(): tests=". Dumper(\@tests) if $debug;
	foreach my $test (@tests)
	{
		say "test $test" if $debug;
		my( $s, $p, $result ) = split( /:/, $test );
		$result //= '0';
		my $match = patmatch( $p, $s );
		#say "p=$p, s=$s, match=$match" if $debug;
		is( $result, $match, " match($s,$p)=$result" );

	}
	done_testing();
}
