package Interpreter;

# Here's the interpreter for a list of APIs.  This is the guts of
# pattern matching.

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Data::Dumper;
use Exporter;
our @ISA = qw(Exporter);

our @EXPORT_OK = qw(interprete); # Export on demand

use lib qw(.);
use API;
use PosExpr;

my $debug = 0;

sub setdebug { my($d) = @_; $debug = $d; }


#
# my $ok = runAt( $s, $lit, $at, $poshash, $name );
#	Try to match $lit in $s at $at.  Return 0 if we can't
#	find that literal.  1 otherwise (and store name==pos in the poshash)
#
fun runAt( $s, $lit, $at, $poshash, $name )
{
	my $pos = $at->eval($poshash);
	return 0 unless substr($s,$pos,length($lit)) eq $lit;
	$poshash->{$name} = $pos;
	say "debug: A: set pos[$name] = $pos" if $debug;
	return 1;
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
# my $ok = runMatch( $s, $lit, $atorafter, $poshash, $name, $restapi, $mtlist );
#	Try to find $lit in $s at-or-after position $atorafter.  Return 0 if we
#	can't find that literal anywhere.  For each position location that
#	literal does occur at, try each one in turn - running the whole of the
#	rest of the API list @$restapi against each one.  Return 1 if any one
#	of them leads to an overall match.
#	So: 0==fail. 1==stop interpreter.
#
fun runMatch( $s, $lit, $atorafter, $poshash, $name, $restapi, $mtlist )
{
	$atorafter = $atorafter->eval($poshash);
	my @litpos = findliteral( $lit, $atorafter, $s );
	return 0 if @litpos==0;

	# must try each possible position in @litpos in turn
	say "debug: M: try each pos ".join(',',@litpos) if $debug;

	foreach my $pos (@litpos)
	{
		$poshash->{$name} = $pos;
		say "debug: try pos[$name] = $pos" if $debug;
		my $match = interprete( $s, $restapi, $poshash, $mtlist );
		say "debug: matchrest = $match" if $debug;
		return 1 if $match;
		undef $poshash->{$name};
	}
	return 0;
}


#
# my $ok = runTest( $pe1, $op, $pe2, $poshash );
#	Perform a simple test: Evaluate both PosExprs $pe1 and $pe2
#	down to numeric values, then compare those values via the
#	operator $op ('>', '=' or '>=').
#	Return 1 iff $pe1 ($op) $pe2.  0 otherwise.
#
fun runTest( $pe1, $op, $pe2, $poshash )
{
	my $pv1 = $pe1->eval($poshash);
	my $pv2 = $pe2->eval($poshash);
	return 0 if $op eq '>' && $pv1 <= $pv2;
	return 0 if $op eq '>=' && $pv1 < $pv2;
	return 0 if $op eq '=' && $pv1 != $pv2;
	return 1;
}


#
# my $cap = runCapture( $s, $pefrom, $peto, $poshash, $mtlist );
#	Capture a portion of $s and push it onto @$mtlist.
#	Evaluate $pefrom and $peto to numeric values $f and $t,
#	then extract the substring of $s from $f, to $t, and
#	then push that substring onto @$mtlist.  Also return that
#	same substring.
#
fun runCapture( $s, $pefrom, $peto, $poshash, $mtlist )
{
	my $from = $pefrom->eval($poshash);
	my $to = $peto->eval($poshash);
	my $cap = substr($s,$from,$to-$from+1) // '';
	push @$mtlist, $cap;
	return $cap;
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
		if( $kind eq 'A' )		# Match at pos
		{
			my( $lit, $at, $name ) = $api->A;
			return 0 unless runAt( $s, $lit, $at, $poshash, $name );
		}
		elsif( $kind eq 'M' )		# Match at or after - tricky
		{
			my( $lit, $atorafterpos, $name ) = $api->M;

			# Build the rest of the api list..
			my @restapi = @$apilist[$n+1..$#$apilist];

			my $ok = runMatch( $s, $lit, $atorafterpos,
				  $poshash, $name, \@restapi, $mtlist );
			return $ok; #.. if $ok < 2;

		}
		elsif( $kind eq 'T' )
		{
			my( $pe1, $op, $pe2 ) = $api->T;
			my $ok = runTest( $pe1, $op, $pe2, $poshash );
			return 0 unless $ok;
			say "debug: test $api succeeded" if $debug;
		}
		elsif( $kind eq 'C' )
		{
			my ($pe1, $pe2) = $api->C;
			my $mn = @$mtlist;
			my $cap = runCapture( $s, $pe1, $pe2, $poshash, $mtlist );
			say "debug: C: set mt[$mn] to $cap" if $debug;
		}
		else
		{
			die "interprete: not yet implemented $kind\n";
		}
		$n++;
	}
	return 1;
}


1;
