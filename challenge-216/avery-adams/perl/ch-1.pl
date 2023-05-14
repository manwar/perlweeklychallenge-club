#!/usr/bin/perl

use strict;
use warnings;
use v5.24;

my %reg;
foreach (split(//, shift)) {
    my ($char) = ($_ =~ /([[:alpha:]])/);
    $reg{lc($char)}++ if $char;
}

WORD:
foreach (@ARGV) {
    my $word = $_;
    MATCH:
    foreach (keys %reg) {
        my $char = $_;
        my $count = $reg{$_};

        next WORD if $word !~ /${char}{$count,}/;
    }
    say $word;
}
