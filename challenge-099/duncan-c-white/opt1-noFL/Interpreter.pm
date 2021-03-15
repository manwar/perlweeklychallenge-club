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
		if( $kind eq 'A' )		# Match at pos
		{
			my( $lit, $at, $name ) = $api->A;
			my $pos = $at->eval($poshash);
			return 0 unless substr($s,$pos,length($lit)) eq $lit;
			$poshash->{$name} = $pos;
			say "debug: A: set pos[$name] = $pos" if $debug;
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
			return 0 if $op eq '>=' && $pv1 < $pv2;
			return 0 if $op eq '=' && $pv1 != $pv2;
			say "debug: test $api succeeded" if $debug;
		}
		elsif( $kind eq 'C' )
		{
			my ($pe1, $pe2) = $api->C;
			my $from = $pe1->eval($poshash);
			my $to = $pe2->eval($poshash);
			my $cap = substr($s,$from,$to-$from+1) // '';
			my $mn = @$mtlist;
			push @$mtlist, $cap;
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
