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
# In this version (having already got (1) working in ch-1.pl), let's do (2).
# I've invented "Abstract Pattern Instructions (APIs)", and am writing an
# interpreter for them in order to do the matching.  To make life interesting,
# let's also capture the matching text for each '?' and '*'.  I've got this
# working; see API.pm and PosExpr.pm too..  This proves that "interpreting a
# list of APIs" will do pattern matching.
#
# Next, I need to work out how to translate our patterns into a list of APIs.
# I have some ideas, and notes, but not a full method worked out.
# I think the first concept is: divide the pattern up into "fixed size islands"
# containing string literals and adjacent '?'s, i.e. anything but a '*'A,
# separated by patches of sea: each seapatch is a single '*'
# [NB: '**' and '*(?)+*' have already been ruled out, detected and trapped]
#
# Note: I also added a test suite (the above examples) with --test.
# 

use strict;
use warnings;
use Getopt::Long;
use feature 'say';
use Function::Parameters;
use Data::Dumper;

our $debug=0;
our $test=0;

use lib qw(.);
use PatternMatch qw(patternmatch);

die "Usage: pattern-match [--test] [--debug]\n".
    "Or...  pattern-match [--debug] S P\n"
	unless GetOptions( "debug" => \$debug, "test" => \$test )
	    && ($test && @ARGV==0 || !$test && @ARGV==2);
PatternMatch::setdebug( $debug );

if( $test )
{
	dotests();
	exit 0;
}

my( $s, $pat ) = @ARGV;

my( $matched, @matchtext ) = patternmatch( $s, $pat );
say "Output: $matched";
if( $matched )
{
	foreach my $i (0..$#matchtext)
	{
		say " match text $i: $matchtext[$i]";
	}
}


#
# dotests();
#	Do a load of tests.
#
sub dotests
{
	eval "use Test::More"; die $@ if $@;
	eval "use TestPatternMatch qw(match_tests)"; die $@ if $@;

	TestPatternMatch::setdebug( $debug );

	match_tests();

	done_testing();
}
