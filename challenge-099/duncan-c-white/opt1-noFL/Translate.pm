package Translate;

#
# Contains the code to Translate a pattern to a list of APIs.
#

use strict;
use warnings;
use Getopt::Long;
use feature 'say';
use Function::Parameters;
use Data::Dumper;

use Exporter;
our @ISA = qw(Exporter);

our @EXPORT_OK = qw(pat2apis); # Export on demand

use lib qw(.);
use API;
use PosExpr;


my $debug = 0;

sub setdebug { my($d) = @_; $debug = $d; }


#
# my $name = str2name($str);
#	Given a string literal $str, determine a unique pos
#	name $name.  Usually this is the first letter of $str
#	followed by a disambiguating number.
#
my %knownstr2name;
fun str2name( $str )
{
	die "str2name: empty str $str!\n" unless $str;
	$str =~ /^(.)/;
	my $first = $1;
	$first = 'p' unless $first =~ /^[0-9a-z]/;	# if not alphanumeric..
	if( exists $knownstr2name{$first} )
	{
		my $i;
		for( $i=1; exists $knownstr2name{"$first$i"}; $i++ )
		{
		}
		$knownstr2name{"$first$i"}++;
		return "$first$i";
	}
	$knownstr2name{$first}++;
	return $first;
}


#
# my $api = mkapi( $str );
#	Wrapper: Turns a string into an API element or dies trying.
#
fun mkapi( $str )
{
	my @api = API::parse($str);
	if( $debug )
	{
		$str =~ /^(.)/;	# grab first char
		my $msg = $1 eq 'C' ? 'capture' : '+';
		say "$msg $str";
	}
	return $api[0];
}

#
# my $pe = sp( $str );
#	Wrapper: Turns a string into a PosExpr or dies trying.
#
fun sp( $str ) { return PosExpr::simpleparse($str); }


#
# my( $newlpos, @api ) = fixedisland( $island, $lpos, $captures );
#	We have a fixed-width island (a pattern with no '*'s) called $island,
#	which must start at posexpr $lpos (so it can be symbolic).
#	Translate the island into a list of APIs, and return that list along
#	with the new lpos after matching it.
#	Store any associated text captures (also APIs) in @$captures in left
#	to right order (one capture per '?') - they will be added to the final
#	list of apis at the end of the whole pattern match (NOT HERE).
#
fun fixedisland( $island, $lpos, $captures )
{
	say "island $island @ $lpos" if $debug;
	if( $island !~ /\?/ )			# string literal?
	{
		my $name = str2name($island);
		my $l = length($island);
		my $api = mkapi("A'$island' $lpos->$name");
		$lpos = sp("$name+$l");
		return ( $lpos, $api );
	}

	# ok, the island has at least one '?', maybe more
	# build captures as we go along, from left to right
	my @api;
	while( $island )
	{
		if( $island =~ s/^([^?]+)// )
		{
			my $str = $1;	# strlit at lpos
			my $l = length($str);
			my $name = str2name($str);
			say "str=$str, name=$name, remaining island=$island";
			my $api = mkapi("A'$str' $lpos->$name");
			push @api, $api;
			my $advance = length($str);
			$lpos = sp("$name+$advance");
		} else
		{
			$island =~ s/^\?//;
			# found a '?'
			push @$captures, mkapi("C $lpos");
			$lpos = $lpos->add(1);
		}
		say "debug: island now $island, lpos now $lpos" if $debug;
	}
	return ( $lpos, @api );
}


#
# my( $newlpos, @api ) = floatingisland( $island, $lpos, $rpos, $captures );
#	Look for a "floating island" $island at or after position $lpos,
#	and allowed to extend up to position $rpos.  Return the new lpos "after
#	the island" and the list of generated API instructions, and append any
#	captures (in left to right order) onto @$captures.
#
fun floatingisland( $island, $lpos, $rpos, $captures )
{
	my @api;
	if( $island !~ /\?/ )		# if the island is a literal...
	{
		my $name = str2name($island);
		my $l = length($island);
		push @api, mkapi("M'$island' $lpos->$name");

		my $pos = $rpos->add(1);
		push @api, mkapi("T$pos>=$name+$l");

		push @$captures, mkapi("C $lpos $name-1");

		$lpos = sp("$name+$l");
		return( $lpos, @api );
	}

	# otherwise island contains at least one '?'
	# find first strlit in $island, counting how many '?'s
	# come before it.
	my $nq = 0;
	while( $island =~ s/^\?// )
	{
		$nq++;
	}
	say "debug: floatisland: found nq=$nq '?'s before first strlit"
		if $debug;

	$island =~ s/^([^?]+)//;	# find and remove first strlit
	my $str = $1;
	my $l = length($str);
	my $name = str2name($str);
	my $p = $lpos->add($nq);	# form lpos+nq: the first poss
					# position that could match
					# the first strlit $str
	push @api, mkapi("M'$str' $p->$name" );

	# generate a capture for the '*' before this island starts
	$p = sp("$name-". ($nq+1) );
	push @$captures, mkapi("C $lpos $p");

	# now generate captures for each of $nq '?'s before the $str
	for( my $i=0; $i<$nq; $i++ )
	{
		$p = $p->add(1);
		push @$captures, mkapi("C $p");
	}

	# now deal with the rest of the floating island, starting at:
	$lpos = sp("$name+$l");

	# could be empty
	return ( $lpos, @api ) unless $island;

	# the rest of it is by definition a fixed island starting @ $name+$l
	( $lpos, my @newapi ) =
			fixedisland( $island, $lpos, $captures );
	push @api, @newapi;
	return ( $lpos, @api );
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
# my @api = pat2apis( $pat );
#	Translate pattern $pat into a list of API objects.
#
fun pat2apis( $pat )
{
	my $lpos = sp('0');
	my $rpos = sp('slen-1');
	return mkapi( "C $lpos $rpos" ) if $pat eq '*';	# special case

	%knownstr2name = ();	# empty str2name cache

	my @api;
	my @captures;

	my $nfix = countfixed( $pat );
	my $len = length($pat);

	if( $nfix == $len )  	# if the whole pattern is fixed - no '*'
	{
		push @api, mkapi("Tslen=$len");	# Test length
		($lpos, my @islandapi ) =
			fixedisland( $pat, $lpos, \@captures );
		push @api, @islandapi, @captures;
		return @api;
	}

	# ok, there's at least 1 '*'.. test the string is long enough, $nfix
	# (the number of fixed elements in the pattern) is the minimum length
	if( $nfix > 0 )
	{
		push @api, mkapi("Tslen>=$nfix");
	}

	$pat =~ s/^([^*]*)//;	# find first island (if any)
	my $island = $1;
	if( $island )
	{
		($lpos, my @islandapi ) =
			fixedisland( $island, $lpos, \@captures );
		push @api, @islandapi;
	}

	$pat =~ s/([^*]*)$//;	# find trailing island (if any)
	$island = $1;
	my @finalcaptures;
	if( $island )
	{
		my $l = length($island);
		my $p = sp("slen-$l");
		my( $lastislandlpos, @islandapi ) =
			fixedisland( $island, $p, \@finalcaptures );
		push @api, @islandapi;
		$rpos = $lastislandlpos->add(-($l+1));
		# NB: need to append @finalcaptures to @captures at the end,
		# before appending @captures to @api.
	}

	# now, pattern comprises * or *island* or *island*island...*
	say "middle part ($pat), rpos=$rpos, lpos=$lpos"
		if $debug;
	if( $pat eq '*' )
	{
		my $p = $rpos->add(1);
		push @api, mkapi("T$p>=$lpos");

		push @captures, mkapi("C $lpos $rpos");
	} else
	{
		$pat =~ s/^\*//;	# remove leading '*'
		while( $pat && $pat =~ s/^([^*]+)\*// )
		{
			my $float = $1;
			say "found * floatingisland '$float' *, lpos=$lpos, ".
			    "rpos=$rpos" if $debug;
			( $lpos, my @fapi ) =
			   floatingisland( $float, $lpos, $rpos, \@captures );
			push @api, @fapi;
		}

		die "pat2apis: logic error, $pat should be empty\n" if $pat;

		# add the capture for the final '*'
		push @captures, mkapi("C $lpos $rpos");
	}

	push @api, @captures, @finalcaptures;
	return @api;
}


1;
