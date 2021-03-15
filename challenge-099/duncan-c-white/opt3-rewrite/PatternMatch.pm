package PatternMatch;

#
# This contains the complete code to pattern match a string against a
# pattern, integrating all the previous code from Translate and Interprete,
# no longer needing APIs, PosExprs or a hash of named variables, essentially
# we will now "parse a bit, match a bit" as we go along.  Captures were
# really confusing me, deep within the search, but I realised that all the
# search (pattern matching) routines could ignore them - leaving them to the
# end.  What you need at the end to construct the matched text snippets
# after a successful match is:
# - a list of all fixed-width Islands
# - 2 booleans: $firststar is true iff the pattern had a leading '*', and
#               $laststar is true iff the pattern had a trailing '*'.
# - a corresponding list of the starting point in the string of each island
# I suspect that I could have turned the pattern string into the list of
# islands and the 2 booleans rather earlier..
#

use strict;
use warnings;
use Getopt::Long;
use feature 'say';
use Function::Parameters;
use Data::Dumper;

use Exporter;
our @ISA = qw(Exporter);

our @EXPORT_OK = qw(patternmatch extractmatchedtext); # Export on demand

use lib qw(.);
use Tuple qw(tuple);


my $debug = 0;

sub setdebug { my($d) = @_; $debug = $d; }


#
# my $ok = matchAt( $target, $strlit, $pos );
#	Return 1 iff $strlit matches $target starting at $pos.
#	Return 0 otherwise.
#
fun matchAt( $target, $strlit, $pos )
{
	return substr($target,$pos,length($strlit)) eq $strlit ? 1 : 0;
}


#
# my $nfix = countfixed( $pat );
#	Count the number of fixed-width elements in $pat, ie.
#	literal characters and '?' - anything but '*' in fact.
#
fun countfixed( $pat )
{
	my $result = grep { $_ ne '*' } split(//,$pat);
	return $result;
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
# my $found = fixedisland( $s, $island, $lpos );
#	Pattern match a fixed-width island (a pattern with no '*'s,
#	which can contain strliterals and '?'s) called $island, against
#	$s at exactly $lpos.  If we fail to pattern match, return 0.
#	If we do pattern match successfully, return 1.
#
fun fixedisland( $s, $island, $lpos )
{
	say "fixedisland: island $island @ $lpos, string $s" if $debug;
	if( $island !~ /\?/ )			# string literal?
	{
		my $l = length($island);
		return 0 unless matchAt($s, $island, $lpos);
		return 1;
	}

	# ok, the island has at least one '?', maybe more
	# match each string literal, skip '?'s
	while( $island )
	{
		if( $island =~ s/^([^?]+)// )
		{
			my $strlit = $1;	# strlit at lpos
			my $l = length($strlit);
			say "debug: fixedisland: strlit=$strlit, ".
			    "remaining island=$island" if $debug;
			return 0 unless matchAt( $s, $strlit, $lpos );
			$lpos += $l;
		} else
		{				# '?' at lpos
			$island =~ s/^\?//;
			# found a '?', skip it
			$lpos++;
		}
		say "debug: fixedisland: island now $island, lpos now $lpos" if $debug;
	}
	return 1;
}


#
# my $substr = ft( $s, $from, $to );
#	From-to: extract the substring of $s from pos $from
#	to pos $to.
#
fun ft( $s, $from, $to )
{
	my $sub = substr($s,$from,$to-$from+1) // '';
	return $sub;
}


#
# my @mt = extractmatchedtext( $s, $firststar, $laststar, @is );
#	Given a string $s, a boolean $firststar saying whether there's
#	a '*' before the first island, and a similar boolean $laststar,
#	and an array @is of (fixed-width island, it's start pos in $s) pairs,
#	generate the array of matched text capture fragments.
#
fun extractmatchedtext( $s, $firststar, $laststar, @is )
{
	#say "emt: debug=$debug";
	say "emt: s=$s, is=".Dumper(\@is) if $debug;

	my $slen = length($s);
	my $freel = 0;				# first free pos in string
	my @mt;
	foreach my $oneis (@is)
	{
		my( $island, $startpos ) = $oneis->detuple;

		# there is usually a capture, i.e. a * before the island
		push @mt, ft($s,$freel,$startpos-1)
			unless $freel==0 && ! $firststar;

		# process any '?'s
		my $p = $startpos;
		foreach my $ch (split(//,$island))
		{
			push @mt, substr($s,$p,1) if $ch eq '?';
			$p++;
		}

		# advance freel to first available pos in $s AFTER $island
		$freel = $p;
	}

	if( $laststar )
	{
		push @mt, ft($s,$freel,$slen-1) // '';
	}
	say "emt: mt=".Dumper(\@mt) if $debug;
	return @mt;
}


#
# my( $match, @matchedtext ) = patternmatch( $s, $pat );
#	Pattern match $pat against the whole of $s.
#	If it matches, return (1, the array of captured text fragments)
#		[nb: one text fragment for every ? and * in $pat]
#	If the pattern doesn't match the string, return (0).
#
fun patternmatch( $s, $pat )
{
	die "bad pattern $pat\n" if $pat =~ /\*\?*\*/;

	# capture whole string if the pattern is '*'
	return (1, $s) if $pat eq '*';

	my $firststar = ($pat =~ /^\*/) ? 1 : 0;
	my $laststar = ($pat =~ /\*$/) ? 1 : 0;

	my @is;	# array of [island,startpos] pairs, ie. 2-tuples.
	my $match = patternmatchSP( $s, $pat, \@is );
	return 0 unless $match;

	# now we have a match, turn the @is data into matched texts
	my @mt = extractmatchedtext( $s, $firststar, $laststar, @is );
	return (1, @mt);
}


#
# my $match = patternmatchSP( $s, $pat, $is );
#	Pattern match $pat against the whole of $s, storing all the
#	fixed-width islands in $pat, and their corresponding
#	starting positions in $s, into @$is.
#
#	Return 0 if the whole match fails.
#	If the match succeeds, return 1
#
fun patternmatchSP( $s, $pat, $is )
{
	say "debug: patternmatchSP( $s, $pat )" if $debug;

	my $slen = length($s);
	my $nfix = countfixed( $pat );
	my $len = length($pat);

	if( $nfix == $len )  	# if the whole pattern is fixed - no '*'
	{
		return 0 unless $slen==$len;		# Test length
		return 0 unless fixedisland( $s, $pat, 0 );
		@$is = ( tuple($pat,0) );
		return 1;
	}

	# ok, there's at least 1 '*'.. test the string is long enough, $nfix
	# (the number of fixed elements in the pattern) is the minimum length
	if( $nfix > 0 )
	{
		say "debug: $pat has at least one '*', checking length slen=$slen vs nfix=$nfix" if $debug;
		return 0 if $slen<$nfix;
	}

	my $lpos = 0;
	my $rpos = $slen-1;

	if( $pat =~ s/^([^*]+)// )	# find first island (if present)
	{
		my $island = $1;
		return 0 unless fixedisland( $s, $island, $lpos );
		push @$is, tuple( $island, $lpos );
		$lpos = length($island);
	}

	my $lastis;
	if( $pat =~ s/([^*]+)$// )	 # find trailing island (if present)
	{
		my $island = $1;
		my $l = length($island);
		my $lastsp = $slen-$l;
		return (0) unless fixedisland( $s, $island, $lastsp );

		$lastis = tuple( $island, $lastsp );
		$rpos -= $l;
		# NB: need to add $lastis to @is at the end (if it's >0)
	}

	my $match = matchfloatingislands( $s, $pat, $lpos, $rpos, $is );
	return 0 unless $match;

	push @$is, $lastis if $lastis;
	return 1;
}


#
# my $match = matchfloatingislands( $s, $pat, $lpos, $rpos, $is );
#	Recursive pattern matcher for $pat that comprises * or *island*
#	or *island*island...*, ie. a list of zero or more floating islands.
#	Try to pattern match $s against each island in the $pat, all between
#	positions $lpos and $rpos in $s.
#
#	Return 0 if the match fails.  If the match succeeds, return 1 (also
#	having added each ( island, start pos ) pair to @$is.
#
fun matchfloatingislands( $s, $pat, $lpos, $rpos, $is )
{
	say "matchfloatingislands: pattern $pat, string $s, lpos $lpos, rpos $rpos"
		if $debug;

	# what if no islands?
	if( $pat eq '*' )
	{
		return 0 unless $rpos+1 >= $lpos;
		return 1;
	}

	# each island is free floating, and has to be tried
	# everywhere it could possibly match: Try the first..

	# break off the first "*island"
	die "matchfloatingislands: logic error: no island in $pat\n"
		unless $pat =~ s/^\*([^*]+)//;

	my $island = $1;
	say "matchfloatingislands: found * floatingisland '$island' *, lpos=$lpos, ".
	    "rpos=$rpos" if $debug;

	# Look for our "floating island" $island at or after
	# position $lpos, and not allowed to extend beyond
	# position $rpos.

	if( $island !~ /\?/ )	# if the whole island is a literal...
	{
		my $litstr = $island;
		my $l = length($litstr);

		my @lpos = findliteral( $litstr, $lpos, $s );
		return 0 if @lpos==0;

		say "debug: found $litstr at positions ".join(',',@lpos)
			if $debug;

		# must try each possible position in @lpos in turn
		@lpos = map { $_+$l } @lpos;	# positions AFTER the litstr

		say "debug: free positions after $litstr ".join(',',@lpos)
			if $debug;

		my @extrais;
		my $pos = tryall( $s, $pat, $rpos, \@extrais, @lpos );
		return 0 unless $pos;
		return 0 unless $rpos+1>=$pos;

		$pos -= $l;	# $pos is the starting position at which
				# the island (and, after it, the rest of
				# the pattern) matched.

		push @$is, tuple($island, $pos);

		# then add any extra (island,startpos) pairs
		push @$is, @extrais;

		return 1;
	}

	# otherwise island contains at least one '?':
	# find first strlit in $island, counting how many '?'s
	# come before it.
	my $origisland = $island;
	my $nq = 0;
	while( $island =~ s/^\?// )
	{
		$nq++;
	}
	say "debug: floatisland: found nq=$nq '?'s before first strlit"
		if $debug;

	$island =~ s/^([^?]+)//;	# find and remove first strlit
	my $litstr = $1;
	my $l = length($litstr);
	my $p = $lpos+$nq;		# the first possible position that
					# could match the first strlit $litstr

	# Match $litstr at or after $p:
	my @lpos = findliteral( $litstr, $p, $s );
	return 0 if @lpos==0;

	say "debug: found $litstr at positions ".join(',',@lpos)
		if $debug;

	# must try each possible position in @lpos in turn
	@lpos = map { $_+$l } @lpos;	# positions AFTER the litstr

	say "debug: free positions after $litstr ".join(',',@lpos)
		if $debug;

	# reject possible positions unless we can match the rest of this
	# island (by definition a fixed island starting at that position),
	# or the rest of the island is empty.
	@lpos = grep {
		$island eq '' || fixedisland( $s, $island, $_ );
	} @lpos;

	say "debug: free positions after $litstr and rest of $island ".join(',',@lpos)
		if $debug;

	return 0 if @lpos==0;

	my $l2 = length($island);
	@lpos = map { $_+$l2 } @lpos;	# positions AFTER the end of the island

	say "debug: free positions after end of $island ".join(',',@lpos)
		if $debug;

	my @extrais;
	my $pos = tryall( $s, $pat, $rpos, \@extrais, @lpos );
	return 0 unless $pos;
	return 0 unless $rpos+1>=$pos;

	$pos -= $l+$l2+$nq;	# reset $pos to the starting position
				# of the WHOLE ORIGINAL ISLAND

	push @$is, tuple( $origisland, $pos );
	push @$is, @extrais;
	return 1;
}


#
# my $pos = tryall( $s, $pat, $rpos, $is, @lpos );
#	Try matching the entire pattern $pat against string $s, at every
#	left position in @lpos, up to and including $rpos.
#	Return 0 if all fail; When you find one that matches, return the
#	element of @lpos.  If we succeed, it adds (island,startpos) pairs
#	to @$is.
#
fun tryall( $s, $pat, $rpos, $is, @lpos )
{
	foreach my $pos (@lpos)
	{
		say "debug: try matching pattern $pat to $s @ $pos, is=".Dumper($is) if $debug;
		my @copyis = @$is;
		my $match = matchfloatingislands( $s, $pat, $pos, $rpos, \@copyis );
		say "debug: matching pattern @ $pos = $match" if $debug;
		if( $match )
		{
			@$is = @copyis;
			return $pos;
		}
	}
	return 0;
}


1;
