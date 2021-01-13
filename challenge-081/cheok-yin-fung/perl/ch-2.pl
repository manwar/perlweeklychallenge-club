#!/usr/bin/perl
# The Weekly Challenge - Perl & Raku #081 Task 2
# Frequency Sort

use strict;
use warnings;
#use Data::Dumper;

open LITERATURE, "<", "input";

my %wordcount;

while (<LITERATURE>) {
    s/(\.|"|\(|\)|,|'s|--)/ /g;
    for my $chunk (split) {
        $wordcount{$chunk}++;
    }
}

my %wordfreq;

foreach my $word (sort keys %wordcount) {
    $wordfreq{$wordcount{$word}}.= " $word";
}

foreach my $i (sort keys %wordfreq) {
    print $i,$wordfreq{$i},"\n\n";
}

#print Dumper(%wordfreq);
#print Dumper(%wordcount);
