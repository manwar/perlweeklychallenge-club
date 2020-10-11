#!/usr/bin/env raku
#
# Task 2 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-081/

# Run:
# $ raku ch-2.raku

my $text = 'input.txt'.IO.slurp;

my %freq;
%freq{$_}++ for $text ~~ m:g/(\w+)/;

my @freq = %freq.values.unique.sort;

my @output;
for @freq -> $freq {
    my @words = (%freq.grep: *.value == $freq).map: *.key;
    @output.push: ($freq, @words.sort).join: ' ';    
}

@output.join("\n\n").say;
