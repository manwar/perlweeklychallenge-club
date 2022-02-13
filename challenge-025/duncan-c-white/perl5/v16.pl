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

my %sw;	     # hash from letter L to list of word nos of words STARTING with L

my @stopword;# list of stop word nos (word nos of words with no words going
	     # "out" from them onto another word, ie. word numbers N where
	     # no other word starts with the last letter of word N)

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

my @seqs = findall();

show_seqs( @seqs ) if $debug;

exit 0;


#
# my @suset = suset( $wno );
#	Form a SUset in which all word nos are unused, except $wno.
#
fun suset( $wno )
{
	my @suset = (0) x scalar(@words);
	$suset[$wno] = 1;
	return @suset;
}


#
# show_seqs( @seqs );
#	Show the sequences (as words, not word nos)
#
fun show_seqs( @seqs )
{
	foreach my $s (@seqs)
	{
		my $str = join( ',', map { $words[$_] } split(/,/,$s) );
		print "$str\n";
	}
}


#
# show_sus( @sus );
#	Show the sequences (as words, not word nos) contained in SUlist @sus
#
fun show_sus( @sus )
{
	foreach my $s (@sus)
	{
		my $str = $s->[1];
		print "$str\n";
	}
}


#
# my @seqs = findall();
#	Find all sequences, starting with sequences of length 1 (stop words),
#	then working back, i.e. prepending words onto the front of existing
#	sequences.  Delivers the list of all maximal-length sequences.
#
fun findall(  )
{
	my @sus;	# array of two SU lists, sus[curr] stores the current
			# list of all SUs for sequences of length N,
			# sus[1-curr] builds the NEW list of
			# all SUs for sequences of length N+1
			# each SU entry is now a triple:
			#	[ firstwno, seqstr, usedarrayref ]
			# (where the sequence is now seqstr, a single string
			# comprising the comma-separated list of word nos,
			# always starting with firstwno)
	my $N = 1; 	# length starts at 1 and is increased..
	my $curr = 0;   # start using sus[0] for curr, sus[1] for new..

	# convert each stopword word no into a SU triple
	@sus = ( [], [] );
	@{$sus[0]} = map { [ $_, $_, [ suset($_) ] ] } @stopword;

	for(;;)
	{
		my $currsus = $sus[$curr];
		#die Dumper $currsus;
		my $nseq = @$currsus;
		print "Have $nseq sequences of length $N\n";
		#show_sus( @$currsus );

		#
		#	Now let's take every SU (firstwno/sequence/used set) in
		#	sus[curr], and lengthen them (storing the results
		#	in sus[1-curr]), prepending a word number to the start
		#	of each sequence.  This will be possible unless all
		#	sequences in sus[curr] are already at their maximal
		#	length - when that happens, we break out of the loop.
		#
		my $newsus = $sus[1-$curr];
		#@$newsus = ();
		undef @$newsus;
		foreach my $su (@$currsus)	# foreach current SU
		{
			my( $firstwno, $s, $used ) = @$su;

			# find the list of word nos into firstwno
			my $list = $inword[$firstwno];

			# for each unused word no going into firstwno
			foreach my $wno (grep { ! $used->[$_] } @$list)
			{
				# make length N+1 sequence, cons(wno,oldseq)
				my $news = "$wno,$s";

				# alter the used array, marking $wno used.
				$used->[$wno] = 1;

				# build a whole new SU!
				push @$newsus, [ $wno, $news, [ @$used ] ];

				# alter used back
				$used->[$wno] = 0;
			}
		}
	last if @$newsus == 0;
		$N++;
		$curr = 1-$curr;
	}

	# now extract and return all the maximal length sequences

	my $currsus = $sus[$curr];
	return map { $_->[1] } @$currsus;
}
