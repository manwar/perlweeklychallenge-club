#!/usr/bin/perl
#
# Challenge 2: "Write a script to find out the DayLight gain/loss in
# the month of December 2019 as compared to November 2019 in the city of
# London. You can find out London sunrise and sunset data for November 2019 here:
# https://www.timeanddate.com/sun/uk/london?month=11&year=2019
# 
# and for December 2019 here:
# https://www.timeanddate.com/sun/uk/london?month=12&year=2019
# "
# 
# My notes: most of this problem is fetching the web pages and parsing the
# information out of the first table in each page: that's a typical
# HTML::Parser state machine, easy enough.  But once we have that information,
# eg. for each month a day->daylight duration mapping, what exactly does the
# question mean us to do?  
# 
# I think this problem means
# 
# "calculate the difference between the amount of daylight on 1st Nov and on
# 30th Nov, do the same for December (1st and 31st), and find out which
# "within month daylight duration" is smaller."
# 
# btw, if I'm right the smaller duration is obviously between 1st-31st Dec
# than between 1st-30th Nov, because in November the days are getting shorter
# throughout the whole month, whereas in December they get shorter from
# 1st-21st Dec, and then get longer again!
# 

use v5.10;	# to get "say"
use strict;
use warnings;
use Function::Parameters;
use LWP::Simple;
use HTML::Parser;
use File::Slurp;
use Time::Piece;
use Data::Dumper;

my $novurl = "https://www.timeanddate.com/sun/uk/london?month=11&year=2019";
my $decurl = "https://www.timeanddate.com/sun/uk/london?month=12&year=2019";


my $debug_parse=0;

fun start( $t, $p )
{
	print "start<$t>\n" if $debug_parse;
	#print Dumper($p) if $debug_parse;
	#die;
	if( $t eq "table" )
	{
		$p->{tableno}++;
		print "in table $p->{tableno}, want_table = $p->{want_table}\n" if $debug_parse;
		$p->{inwantedtable} =
			($p->{tableno} == $p->{want_table}) ? 1 : 0;
		return unless $p->{inwantedtable};
		print "in wanted table: table $p->{tableno}\n" if $debug_parse;
		$p->{rowno} = -1;
		return;
	}
	if( $p->{inwantedtable} && $t eq "tr" )
	{
		$p->{rowno}++;
		print "in wanted table: table $p->{tableno}, row $p->{rowno}\n" if $debug_parse;
		$p->{colno} = -1;
		$p->{row} = [];
		return;
	}
	if( $p->{inwantedtable} && $t =~ /^(td|th)$/ )
	{
		$p->{colno}++;
		print "in wanted table: table $p->{tableno}, ".
		      "row $p->{rowno}, column $p->{colno}\n" if $debug_parse;
		$p->{inwantedcell} =
			$p->{want_columns}->{ $p->{colno} } ? 1 : 0;
		if( $p->{inwantedcell} )
		{
			print "capturing wanted cell column $p->{colno} in ".
			      "row $p->{rowno}\n" if $debug_parse;
			$p->{celltext} = '';
		}
	}
}


fun text( $t, $p )
{
	return unless $p->{inwantedcell};
	print "text<$t> in wanted cell\n" if $debug_parse;
	$t =~ s/^\s+//m;
	$t =~ s/\s+$//m;
	$p->{celltext} .= $t;
	print "debug: text: <<$t>>, celltext after: <<$p->{celltext}>>\n" if $debug_parse;
}


fun end( $t, $p )
{
	print "end<$t>\n" if $debug_parse;
	if( $t eq "table" )
	{
		print "leaving table $p->{tableno}\n" if $debug_parse;
		$p->{inwantedtable} = 0;
		$p->{inwantedcell} = 0;
	} elsif( $p->{inwantedcell} && $t =~ /^(td|th)$/ )
	{
		$p->{inwantedcell} = 0;
		push @{$p->{row}}, $p->{celltext};
		print "at end of wantedcell, celltext=$p->{celltext}, row=", Dumper($p->{row}) if $debug_parse;
		$p->{celltext} = '';
	} elsif( $p->{inwantedtable} && $t eq "tr" )
	{
		push @{$p->{info}}, [ @{$p->{row}} ] if @{$p->{row}};
		print "ending row in wantedtable: p->{info} is ", Dumper( $p->{info} ) if $debug_parse;
		$p->{row} = [];
		$p->{colno} = -1;
		$p->{inwantedcell} = 0;
	}
}


#
# my %info = parse_table( $htmltext, %want );
#	Given an HTML page $htmltext, and a specification of what parts
#	of what table we want, find and parse the corresponding table,
#	extract the wanted columns of each row, and build and return @info:
#	an array of [ those column values ] tuples.
#
fun parse_table( $htmltext, %want )
{
	my $p = HTML::Parser->new( api_version => 3,
				   start_h       => [\&start, "tagname, self"],
				   end_h         => [\&end,   "tagname, self"],
				   text_h        => [\&text,  "dtext, self"],
				   unbroken_text => 1,
				 );

	$p->{want_table}    = $want{tableno};	# which table we want..

						# set of which columns we want
	$p->{want_columns} = { map { $_ => 1 } @{$want{columns}} };
	#die Dumper $p->{want_columns};

	$p->{tableno}       = -1;		# how many tables seen so far?
	$p->{inwantedtable} = 0;		# are we in the WANTED table?
	$p->{colno}         = -1;		# which column in now?
	$p->{rowno}         = -1;		# which row no we're in now?
	$p->{inwantedcell}  = 0;		# want this table cell?
	$p->{celltext}      = '';		# cell text we're building
	$p->{row}           = [];		# row we're building
	$p->{info}          = [];		# the answer - list of rows

	#die Dumper $p;

	# Parse document text
	$p->parse($htmltext);

	my @result = @{$p->{info}};

	$p->eof;                 # signal end of document

	return @result;
}


#
# my( $diff, $diffms ) = duration( $name, @month );
#	Given a month info array for month $name, a list of
#	[ dayno, dayduration ] pairs, calculate the difference in
#	dayduration between the 1st dayno and the last.  Return it
#	in two forms: as an integer (seconds) and as an mm{m}ss{s} string.
#
fun duration( $name, @month )
{
	my $first = $month[0][1];
	print "\nduration 1st of $name: $first\n";
	my $novdays = @month;
	my $last = $month[$novdays-1][1];
	print "duration last day in $name: $last\n";

	my $t1 = Time::Piece->strptime( $last, '%H:%M:%S' );
	my $t2 = Time::Piece->strptime( $first, '%H:%M:%S' );
	my $diff = $t2 - $t1;

	my $mins = int($diff/60);
	my $secs = $diff%60;
	my $hs = "${mins}m${secs}s";
	print "$name diff: $diff ($hs)\n";

	return( $diff, $hs );
}


my %want;
$want{tableno}   = 0;		# want first table..
$want{columns} = [ 0,3 ];	# which columns we want

#my $html = read_file( "eg.html" );
#my @info = parse_table( $html, %want );

my $html = get($novurl) || die "can't get $novurl\n";
my @nov = parse_table( $html, %want );

# only want 2-tuples where both values start with a digit..
@nov = grep { @$_ == 2 && $_->[0] =~ /^\d/ && $_->[1] =~ /^\d/ } @nov;

$html = get($decurl) || die "can't get $decurl\n";
my @dec = parse_table( $html, %want );

# only want 2-tuples where both values start with a digit..
@dec = grep { @$_ == 2 && $_->[0] =~ /^\d/ && $_->[1] =~ /^\d/ } @dec;

#print "nov: ", Dumper \@nov;
#print "dec: ", Dumper \@dec;

my( $nd, $ndhs ) = duration( "Nov", @nov );
my( $dd, $ddhs ) = duration( "Dec", @dec );

print "\n";

if( $nd < $dd )
{
	print "Nov diff smaller: $nd: $ndhs\n";
} else
{
	print "Dec diff smaller: $dd: $ddhs\n";
}
