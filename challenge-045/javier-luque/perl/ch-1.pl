#!/usr/bin/perl
# Test: ./ch-1.pl The quick brown fox jumps over the lazy dog
use strict;
use warnings;
use feature qw /say/;

my $string = join '', @ARGV;
$string =~ s/\s//g;
my @chars = split('', $string);
my @new_words;

for my $i (0..scalar(@chars)-1) {
    $new_words[$i % 8] .= $chars[$i];
}

say join ' ', @new_words;
