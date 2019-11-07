#!/usr/bin/env perl
use v5.14;
use strict;
use warnings;

my $csv;
if (@ARGV and $ARGV[0] eq '--csv') {
    $csv = 1;
    shift @ARGV;
}
push @ARGV, "example.txt" unless @ARGV;

MAIN: {
    my %words;
    while (<<>>) {
        chomp;
        $words{$_}++;
    }

    my @sorted = reverse sort { $words{$a} <=> $words{$b} } keys %words;
    for my $word (@sorted) {
        if ($csv) {
            say "$word," . $words{$word};
        } else {
            say "$word\t" . $words{$word};
        }
    }
}

