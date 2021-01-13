#!/usr/bin/perl
# Test: ./ch-2.pl

use strict;
use warnings;
use feature qw /say/;
use Tree::Trie;

my @words = qw[
    alphabet  book    carpet
    cadmium   cadeau  alpine
];
my $trie = Tree::Trie->new;
$trie->add(@words);

# Find each answer
my @answers;
for my $word (@words) {
    my @letters = split('', $word);
    my $search_word = '';

    for my $letter (@letters) {
    	$search_word .= $letter;
    	my @counts = $trie->lookup($search_word);

    	# If there is only one word left,
    	# we are unique
    	if (scalar(@counts) == 1) {
    		push @answers, $search_word;
    		last;
    	}
    }
}

say join ', ', @answers;
