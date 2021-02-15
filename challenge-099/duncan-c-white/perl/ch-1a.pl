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
# Of course I'll eventually need to work out how to translate our patterns
# into a list of APIs, but I haven't got time for this now.  So this is an
# incomplete proof-of-concept, that "interpreting a list of APIs" will do
# pattern matching, even if I don't yet know how to translater a pattern into
# a list of APIs.
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

my $debug=0;
my $test=0;
die "Usage: pattern-match [--test] [--debug]\n".
    "Or...  pattern-match [--debug] S cvslist(API)\n"
	unless GetOptions( "debug" => \$debug, "test" => \$test )
	    && ($test && @ARGV==0 || !$test && @ARGV>=2);
API::setdebug( $debug );
PosExpr::setdebug( $debug );

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
# my @litpos = findliteral( $lit, $p, $s );
#	Find all instances of $lit atorafter position $p in $s,
#	build and return a list of possible starting positions.
#
fun findliteral( $lit, $p, $s )
{
	my $slen = length($s);
	my $llen = length($lit);
	my @result = grep { substr($s,$_,$llen) eq $lit; } $p..$slen-1;
	#die "findliteral: lit=$lit, s=$s, results=".Dumper(\@result);
	return @result;
}


#
# my $match = interprete( $s, $apilist, $poshash, $mtlist );
#	Interprete @$apilist against the string $s, using (and modifying)
#	%$poshash which maps names to their positions.
#	Return 1 for a match (filling in @$mtlist) or 0 for no match.
#
fun interprete( $s, $apilist, $poshash, $mtlist )
{
	my $slen = length($s);
	my $n = 0;
	foreach my $api (@$apilist)
	{
		my $kind = $api->kind;
		if( $kind eq 'F' )
		{
			my( $lit, $name ) = $api->F;
			return 0 unless substr($s,0,length($lit)) eq $lit;
			$poshash->{$name} = 0;
			say "debug: F: set pos[$name] = 0" if $debug;
		}
		elsif( $kind eq 'L' )
		{
			my( $lit, $name ) = $api->L;
			my $startpos = $slen-length($lit);
			return 0 unless substr($s,$startpos) eq $lit;
			$poshash->{$name} = $startpos;
			say "debug: L: set pos[$name] = $startpos" if $debug;
		}
		elsif( $kind eq 'M' )		# Match at or after - tricky
		{
			my( $lit, $atorafterpos, $name ) = $api->M;
			my $atorafter = $atorafterpos->eval($poshash);
			my @litpos = findliteral( $lit, $atorafter, $s );
			return 0 if @litpos==0;

			# must try each possible position in @litpos in turn
			if( @litpos == 1 )
			{
				$poshash->{$name} = $litpos[0];
	say "debug: M: set pos[$name] = $litpos[0]" if $debug;
			} else
			{
	say "debug: M: try each pos ".join(',',@litpos) if $debug;
				# Try the rest of the api list..
				my @restapi = @$apilist[$n+1..$#$apilist];

				# for each possible pos of the match
				foreach my $pos (@litpos)
				{
					$poshash->{$name} = $pos;
	say "debug: try pos[$name] = $pos" if $debug;
					my $match = interprete(
					   $s, \@restapi, $poshash, $mtlist );
	say "debug: matchrest = $match" if $debug;
					return 1 if $match;
					undef $poshash->{$name};
				}
				return 0;
			}
		}
		elsif( $kind eq 'T' )
		{
			my( $pe1, $op, $pe2 ) = $api->T;
			my $pv1 = $pe1->eval($poshash);
			my $pv2 = $pe2->eval($poshash);
			return 0 if $op eq '>' && $pv1 <= $pv2;
			return 0 if $op eq '=' && $pv1 != $pv2;
	say "debug: test $api succeeded" if $debug;
		}
		elsif( $kind eq 'C' )
		{
			my ($mn, $pe1, $pe2) = $api->C;
			my $from = $pe1->eval($poshash);
			my $to = $pe2->eval($poshash);
			$mtlist->[$mn] = substr($s,$from,$to-$from+1);
			say "debug: C: set mt[$mn] to $mtlist->[$mn]" if $debug;
		}
		else
		{
			die "interprete: not yet implemented $kind\n";
		}
		$n++;
	}
	return 1;
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

# format of each test: S:P:API(p):expmatch:expmt
my @tests = (
	"abcde:a*e:F'a'->a,L'e'->e,Te>a-1,C0 a+1 e-1:1:bcd",
	"abcde:a*d:F'a'->pa,L'd'->plast,Tplast>pa-1,C0 pa+1 plast-1:0:",
	"abcde:?b*d:L'd'->plast,M'b' 1->pb,Tpb=1,C0 0,C1 pb+1 plast-1:0:",
	"abcde:a*c?e:F'a'->a,L'e'->e,M'c' 1->c,Tc>a,Te=c+2,C0 a+1 c-1,C1 c+1:1:b,d",
	"hellotherehowareyou:*ll*u:L'u'->u,M'll' 0->l,Tu>l+1,C0 0 l-1,C1 l+2 u-1:1:he,otherehowareyo",	# mine own exemplar..
);

	say "dotests(): tests=". Dumper(\@tests) if $debug;
	foreach my $test (@tests)
	{
		say "test $test" if $debug;
		my( $s, $p, $api, $expmatch, $expmts ) = split( /:/, $test );
		$expmatch //= '0';
		my @expectedmt = split(/,/,$expmts);
		my @api = API::parse( $api );
		my( $match, @mt ) = patmatch( $s, @api );
		say "p=$p, s=$s, match=$match, mt=".Dumper(\@mt) if $debug;
		is( $match, $expmatch, " match($s,$p)=$expmatch" );
		is( scalar(@mt), scalar(@expectedmt), "match($s,$p).#matches" );
		foreach my $i (0..$#mt)
		{
			is( $mt[$i], $expectedmt[$i], "match($s,$p).match[$i]" );
		}
	}
	done_testing();
}
