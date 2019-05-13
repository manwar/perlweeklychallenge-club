#!/usr/bin/env perl6

use v6;
use lib 'lib';
use Store;

die "Please pass two words as parameters" unless @*ARGS == 2;
my ($word1, $word2)= @*ARGS;
my $length = $word1.chars;
die "The two words must have the same length\n" if $length != $word2.chars;

my $max = 2 * $length;
my $store-file = "word_store_$length";
my ($stored, %words);
if ($store-file.IO.e) {
    retrieve %words, $store-file;
} else {
    for "words$length.txt".IO.lines -> $word {
        %words{$word} = [];
        for keys %words -> $key {
            if (edit-distance($key, $word) == 1) {
                push @(%words{$key}), $word;
                push @(%words{$word}), $key;
            }
        }
    }
    %words = grep { $_.value.elems > 0 }, %words.pairs;
    store %words, $store-file;
}

sub edit-distance (Str $word1, Str $word2) {
    my @w1 = $word1.comb;
    my @w2 = $word2.comb;
    my $dist = 0;
    $dist++ if @w1[$_] ne @w2[$_] for (0..@w1.end) ;
    return $dist;
}

sub ladder (Str $word1, Str $word2, $tmp-result) {
    return $tmp-result if ($word1 eq $word2);
    return [] if @$tmp-result.elems >= $max;
    my @temp-solutions;
    for @(%words{$word1}) -> $word {
        next if $word eq $word1;
        next if grep { $_ eq $word }, @$tmp-result;
        push @temp-solutions, [|@$tmp-result, $word] and last if $word eq $word2;
        my $new_tmp = ladder($word, $word2, [|@$tmp-result, $word]);
        next if @$new_tmp.elems == @$tmp-result.elems;
        next unless @$new_tmp.elems;
        push @temp-solutions, $new_tmp;
    }
    return [] if @temp-solutions.elems == 0;
    my $best_sol = (sort { $_.elems }, @temp-solutions)[0];
    $max = @$best_sol.elems if @$best_sol.elems < $max;
    return $best_sol;
}

for ($word1, $word2) {
    die "Word $_ not found\n" unless  %words{$_} :exists;
}
my $ladder = ladder $word1, $word2, [$word1];

if (@$ladder) {
    say join "->", @$ladder;
} else {
    say "No ladder found for $word1 and $word2"
}
