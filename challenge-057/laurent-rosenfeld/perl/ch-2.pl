#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;
use Data::Dumper;

my @words = qw /alphabet book carpet cadmium cadeau alpine/;
my @prefixes;
my %letters;
for my $word (@words) {
    push @{$letters{ substr $word, 0, 1 }}, $word;
}
for my $letter (sort keys %letters) {
    push @prefixes, $letter and next if @{$letters{$letter}} == 1;
    my $candidate;
    for my $word1 ( @{$letters{$letter}} ) {
        my $prefix_length = 1;
        for my $word2 (@{$letters{$letter}} ) {
            next if $word1 eq $word2;
            my $i = 1;
            $i++ while substr($word1, $i, 1) eq substr($word2, $i, 1);
            if ($i > $prefix_length) {
                $candidate = substr($word1, 0, $i + 1);
                $prefix_length = $i
            }
        }
    push @prefixes, $candidate;
    }
}
say "@prefixes";
