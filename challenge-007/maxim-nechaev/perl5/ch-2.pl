#!/usr/bin/perl -w
use strict;
use Graph::Undirected;
use Algorithm::Combinatorics qw/combinations/;

sub find_shortest_ladder
{
    my ($word1, $word2, $words) = @_;

    my $g = Graph::Undirected->new;
    map { $g->add_vertex($_) } @$words;

    my $len = length($words->[0]) - 1;
    my $iter = combinations($words, 2);
    while( my $pair = $iter->next ) {
	my $diffs = 0;
	foreach my $i (0..$len) {
	    $diffs++ if substr($pair->[0], $i, 1) ne substr($pair->[1], $i, 1);
	    last if $diffs == 2;
	}
	$g->add_edge( @$pair ) if $diffs == 1;
    }
    return $g->SP_Dijkstra($word1, $word2);
}


$ARGV[0] || die "use: $0 filename_dict";
my @words = <>;
@words = map { chomp; $_ } @words;
my @ladder = find_shortest_ladder('water', 'bread', \@words);
print join("\n", @ladder), "\n";
