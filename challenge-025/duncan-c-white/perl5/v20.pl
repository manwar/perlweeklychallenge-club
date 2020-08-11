#!/usr/bin/perl
#
# Challenge 1: "Generate a longest sequence of the following "English Pokemon"
#     names where each name starts with the last letter of the previous name:
# 
#         audino bagon baltoy banette bidoof braviary bronzor carracosta
#         charmeleon cresselia croagunk darmanitan deino emboar emolga
#         exeggcute gabite girafarig gulpin haxorus heatmor heatran ivysaur
#         jellicent jumpluff kangaskhan kricketune landorus ledyba loudred
#         lumineon lunatone machamp magnezone mamoswine nosepass petilil
#         pidgeotto pikachu pinsir poliwrath poochyena porygon2 porygonz
#         registeel relicanth remoraid rufflet sableye scolipede scrafty
#         seaking sealeo silcoon simisear snivy snorlax spoink starly
#         tirtouga trapinch treecko tyrogue vigoroth vulpix wailord
#         wartortle whismur wingull yamask"
# 
# My notes: Clearly defined, nice, potentially tricky, let's do it.
#
# optimization v20: turned for loop that pushes into push map...
# 

use v5.10;	# to get "say"
use strict;
use warnings;
use Function::Parameters;
use Data::Dumper;

my $debug = @ARGV>0;

my @words = qw(audino bagon baltoy banette bidoof braviary bronzor carracosta
	charmeleon cresselia croagunk darmanitan deino emboar emolga
	exeggcute gabite girafarig gulpin haxorus heatmor heatran ivysaur
	jellicent jumpluff kangaskhan kricketune landorus ledyba loudred
	lumineon lunatone machamp magnezone mamoswine nosepass petilil
	pidgeotto pikachu pinsir poliwrath poochyena porygon2 porygonz
	registeel relicanth remoraid rufflet sableye scolipede scrafty
	seaking sealeo silcoon simisear snivy snorlax spoink starly
	tirtouga trapinch treecko tyrogue vigoroth vulpix wailord
	wartortle whismur wingull yamask);
#@words = qw(hello ollie excellent thanks shelter runaround set to);

#die scalar(@words);

my %sw;	     # hash from letter L to list of word nos of words STARTING with L

my @stopword;# list of stop word nos (word nos of words with no outwords)

my %ew;	     # hash from letter L to list of word nos of words ENDING with L

my @inword;  # array from word no N to array of wordnos of words going "in"
	     # to word N, i.e. ending with the first letter of word N
	     # if there are no such words, then []

# build %sw
foreach my $wn (0..$#words)
{
	my $word = $words[$wn];
	$word =~ /^(.)/;
	my $firstletter = $1;
	$sw{$firstletter} //= [];
	push @{$sw{$firstletter}}, $wn;
}
#die Dumper \%sw;

# build %ew
foreach my $wn (0..$#words)
{
	my $word = $words[$wn];
	$word =~ /(.)$/;
	my $lastletter = $1;
	$ew{$lastletter} //= [];
	push @{$ew{$lastletter}}, $wn;
}
#die Dumper \%ew;

# build @stopword, using %sw
foreach my $wn (0..$#words)
{
	my $word = $words[$wn];
	$word =~ /(.)$/;
	my $lastletter = $1;
	my $aref = $sw{$lastletter} // [];
	push @stopword, $wn if @$aref==0;
}
#die Dumper [ map { $words[$_] } @stopword ];

# build @inword, using %ew
foreach my $wn (0..$#words)
{
	my $word = $words[$wn];
	$word =~ /^(.)/;
	my $firstletter = $1;
	my $aref = $ew{$firstletter} // [];
	$inword[$wn]= $aref;
}
#die Dumper \@inword;

# No longer need %sw or %ew..
undef %sw;
undef %ew;

my @seqs = findall();

show_seqs( @seqs ) if $debug;

exit 0;


#
# my @seqs = findall();
#	Find all sequences, starting with sequences of length 1 (stop words),
#	then working back, i.e. prepending words onto the front of existing
#	sequences.
#	Delivers the list of all maximal-length sequences, each sequence is
#	a comma-separated string of word numbers.
#
fun findall()
{
	my $currpaths = [];	# list of all paths for sequences of length N
				# each path entry is now a triple:
				#   [ inwordarrayref, seqstr, availarrayref ]
				# note that seqstr, representing the sequence,
				#  is asingle string comprising the
				#  comma-separated list of word nos
	my $N = 1; 		# length starts at 1 and is increased..

	# convert each stopword word no into a path triple
	@$currpaths = map { [ $inword[$_], $_, availset($_) ] } @stopword;
	#die Dumper $currpaths;

	for(;;)
	{
		#die Dumper $currpaths;
		my $nseq = @$currpaths;
		print "Have $nseq sequences of length $N\n";
		#show_paths( @$currpaths );

		#
		#	Now let's take every path of length N,
		#	and lengthen them to length n+1, by prepending a
		#	word number to the start of each sequence.  This will
		#	be possible unless all sequences in currpaths are
		#	already at their maximal length - when that happens,
		#	we break out of the loop.
		#
		my $newpaths  = [];		# paths of length N+1
		foreach my $path (@$currpaths)	# foreach current path
		{
			my( $inwords, $s, $avail ) = @$path;

			# extend path s by each unused word no in the inwords
			push @$newpaths,
				map {
					# mark $wno no longer available.
					my $newavail = $avail;
					substr( $newavail, $_, 1 ) = 0;

					# build a whole new path, length N+1
					[ $inword[$_], "$_,$s", $newavail ]
				}
				grep { substr($avail,$_,1) eq '1' } @$inwords;
		}
	last if @$newpaths == 0;
		$N++;
		$currpaths = $newpaths;
		#die Dumper $currpaths;
	}

	# now extract and return all the maximal length sequences
	return map { $_->[1] } @$currpaths;
}



#
# my $set = availset( $wno );
#	Form a set in which all word nos are available, except $wno.
#
fun availset( $wno )
{
	my $set = 1 x scalar(@words);
	substr( $set, $wno, 1 ) = 0;
	return $set;
}


#
# show_paths( @paths );
#	Show the sequences (as words, not word nos) contained in @paths
#
fun show_paths( @paths )
{
	foreach my $p (@paths)
	{
		my $str = join( ',', map { $words[$_] } split(/,/,$p->[1]) );
		say $str;
	}
}


#
# show_seqs( @seqs );
#	Show the sequence of word numbers (as words, not word nos)
#
fun show_seqs( @seqs )
{
	foreach my $s (@seqs)
	{
		my $str = join( ',', map { $words[$_] } split(/,/,$s) );
		say $str;
	}
}
