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
# working; see API.pm and PosExpr.pm too..
#
# Of course, for a full solution, I also need to work out how to translate
# our patterns into a list of APIs.  But I haven't done that yet.  So,
# this is an incomplete proof-of-concept, that "interpreting a list of APIs"
# will do pattern matching, even if I don't yet know how to build the api list
# from a pattern.
#
# Note: I also added a test suite (the above examples) with --test.
# 

use strict;
use warnings;
use Getopt::Long;
use feature 'say';
use Function::Parameters;
use Data::Dumper;

use lib qw(.);
use API;
use PosExpr;
use Interpreter qw(interprete);

my $debug=0;
my $test=0;

die "Usage: pattern-match [--test] [--debug]\n".
    "Or...  pattern-match [--debug] S csvlist(API)\n"
	unless GetOptions( "debug" => \$debug, "test" => \$test )
	    && ($test && @ARGV==0 || !$test && @ARGV>=2);
API::setdebug( $debug );
PosExpr::setdebug( $debug );
Interpreter::setdebug( $debug );

if( $test )
{
	dotests();
	exit 0;
}

my( $s, @apistr ) = @ARGV;
my @api = API::parse( join(',',@apistr) );
say "apis:";
say join("\n", map { "  $_" } @api );
my( $matched, @matchtext ) = patmatch( $s, @api );
say "Output: $matched";
if( $matched )
{
	foreach my $i (0..$#matchtext)
	{
		say " match text $i: $matchtext[$i]";
	}
}


#
# my( $matched, @matchtext ) = patmatch( $s, @api );
#	Pattern match @api against $s, returning ( 1, @matchtext ) iff it
#	matches the whole of $s, ( 0 ) otherwise.  Basically this is an
#	Interpreter for the list @api.
#
sub patmatch
{
	my( $s, @api ) = @_;
	say "patmatch: matching api rules against $s" if $debug;
	my %pos;
	$pos{"slen"} = length($s);
	my @mt;
	my $match = interprete( $s, \@api, \%pos, \@mt );
	return ( $match, @mt );
}


#
# dotests();
#	Do a load of tests.
#
sub dotests
{
	eval "use Test::More"; die $@ if $@;
	eval "use TestPE qw(pe_tests)"; die $@ if $@;
	eval "use TestMatch qw(match_tests)"; die $@ if $@;

	TestMatch::setdebug($debug);

	pe_tests();
	match_tests( \&patmatch );

	done_testing();
}
