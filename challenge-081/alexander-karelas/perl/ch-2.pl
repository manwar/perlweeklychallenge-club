#!/usr/bin/env perl

use v5.30;
use warnings;

# read file into string var
open my $fh, "input";
my $text = do {local $/; <$fh>};
close $fh;

# get frequency of each word
my %frequencies;
my @words = split /(?:[\.\"\(\)\,]|\'s|\-\-|\s)+/, $text;
$frequencies{$_}++ foreach @words;

# generate %reverse_frequencies, a map from frequencies to words
my %reverse_frequencies;
while (my ($word, $freq) = each %frequencies) {
    push @{ $reverse_frequencies{$freq} }, $word;
}

# display sorted
foreach my $freq (sort {$a <=> $b} keys %reverse_frequencies) {
    print $freq, (map " $_", sort @{ $reverse_frequencies{$freq} }), "\n\n";
}
