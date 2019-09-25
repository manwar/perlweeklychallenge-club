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
# optimization v8: seqs->sus (don't rebuild used set each time)        7.8s
# optimization v7: complete reimplementation, iterative version        7.8s
# optimization v6: replaced fun->sub just in case fun is slower       11.8s
# ...
# optimization v1: baseline code before starting to optimize:         32.6s.
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

my @sus;	# all SUs for sequences of length N,
		# each entry is a [ seqarrayref, usedarrayref ] pair
my $N = 1; 	# length starts at 1 and is increased..

# convert each stopword wordno into a SU pair, building a list of them all
@sus = map { [ [ $_ ], [ suset($_) ] ] } @stopword;

for(;;)
{
	my $nseq = @sus;
	print "Have $nseq sequences of length $N\n";
	#show_seqs( @sus );
	my $ok = lengthen( \@sus );
last unless $ok;
	$N++;
}

#show_seqs( @sus );


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
# show_seqs( @sus );
#	Show the sequences (as words, not word nos)
#
fun show_seqs( @sus )
{
	foreach my $s (@sus)
	{
		my $str = join( ',', map { $words[$_->[0]] } @$s );
		print "$str\n";
	}
}

exit 0;

#
# my $ok = lengthen( $sus );
#	Take $sus, a reference of a list of SUs, all of length N,
#	where each SU is a [ sequence, usedset ] pair.
#	each sequence ends in a stopword, and try to lengthen them all
#	backwards, ie. prepending a word number to the start of each sequence.
#	If this is possible, then @$sus is altered to deliver the new, longer
#	SUlist (all of length N+1 now), and 1 is returned.  Otherwise, if
#	lengthening is not possible, leave @$sus alone, and return 0.
#
fun lengthen( $sus )
{
	my @curr = @$sus;	# current list of SUs
	my @new;		# new list of SUs

	foreach my $su (@curr)	# foreach current SU
	{
		my( $s, $used ) = @$su;
		my $firstwno = $s->[0];
		my $list = $inword[$firstwno];	# list of word nos into s[0]
		foreach my $wno (grep { ! $used->[$_] } @$list)
		{
			# make a single length N+1 sequence, cons(wno,oldseq)
			my @oneseq = @$s;
			unshift @oneseq, $wno;

			# make an altered used array, with one more used.
			my @used = @$used;
			$used[$wno] = 1;

			# it's a new SU!
			push @new, [ \@oneseq, \@used ];
		}
	}
	if( @new )
	{
		@$sus = @new;
		return 1;
	}
	return 0;
}
