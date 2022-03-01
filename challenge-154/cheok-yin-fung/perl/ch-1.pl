#!/usr/bin/perl
# The Weekly Challenge 154
# Task 1 Missing Permutation
# Usage: 
# $ ch-1.pl [permutations of alphabets; 
#            each alpahabet appears once]

use v5.22.0;
use warnings;
use Algorithm::Permute qw/permute/;
use List::Util qw/uniqstr/;
use Data::Dumper;

my $word = $ARGV[0];
my @collection = @ARGV;

my @sw = split "", $word;

die "Duplicate alphabet in the word input.\n" 
    if scalar @sw != scalar uniqstr @sw;



my $iter = Algorithm::Permute->new(\@sw, length($word));
my @ws;
while (my @res = $iter->next) {
    push @ws, join "", @res;
}

my %bucket = map {$_ => 0} @ws;

for (@collection) {
    if (defined($bucket{$_})) {
        $bucket{$_}++;
    }
    else {
        die "Inconsistency: \"$_\" is not a permutation of \"$word\".\n";
    }
}



for (@ws) {
    say $_ if !($bucket{$_});
}



# $ ch-1.pl PELR PREL PERL PRLE PLER PLRE EPRL EPLR ERPL ERLP ELPR ELRP RPEL RPLE REPL RELP RLPE RLEP LPER LPRE LEPR LRPE LREP
# output of example: LERP
