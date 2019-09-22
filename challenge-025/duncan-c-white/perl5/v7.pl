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

my @seqs;	# all sequences of length N
my $N = 1; 	# length starts at 1 and is increased..

@seqs = map { [ $_ ] } @stopword;	# convert each stopword wordno to a seq 

for(;;)
{
	my $nseq = @seqs;
	print "Have $nseq sequences of length $N\n";
	#show_seqs( @seqs );
	my $ok = lengthen( \@seqs );
last unless $ok;
	$N++;
}

#show_seqs( @seqs );


#
# show_seqs( @seqs );
#	Show the sequences (as words, not word nos)
#
fun show_seqs( @seqs )
{
	foreach my $s (@seqs)
	{
		my $str = join( ',', map { $words[$_] } @$s );
		print "$str\n";
	}
}



#print "\nlongest sequence is length $longest: @longseq\n";
exit 0;

#
# my $ok = lengthen( $seqs );
#	Take $seqs, a reference of a list of sequences, where each sequence
#	is of length N and ends in a stopword, and try to lengthen them all
#	backwards, ie. prepending a word number to the start of each sequence.
#	If this is possible, then @$seqs is altered to deliver the new, longer
#	list of sequences (all of length N+1 now), and 1 is returned.
#	Otherwise, if lengthening is not possible - if no sequence of length N
#	can be extended by any unused word in a valid way, leave @$seq alone,
#	and return 0.
#
fun lengthen( $seqs )
{
	my @curr = @$seqs;	# current sequences
	my @new;		# new sequences

	foreach my $s (@curr)	# foreach current sequence
	{
		my %used = map { $_ => 1 } @$s;
		my $firstwno = $s->[0];
		my $list = $inword[$firstwno];	# list of word nos into s[0]
		foreach my $wno (@$list)
		{
			next if $used{$wno};	# no cycles need apply

			# make a single length N+1 sequence, cons(wno,oldseq)
			my @oneseq = @$s;
			unshift @oneseq, $wno;

			# it's a new sequence!
			push @new, \@oneseq;
		}
	}
	if( @new )
	{
		@$seqs = @new;
		return 1;
	}
	return 0;
}
