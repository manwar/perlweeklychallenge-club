#!/usr/bin/perl
use warnings;
use strict;

my %freq;
while (<>) {
    ++$freq{$_} for split ' ', s/'s|--|[."(),]+/ /gr;
}

my $previous = 0;
my $eol = "";
for my $word (sort { $freq{$a} <=> $freq{$b} || $a cmp $b } keys %freq) {
    print "$eol", $previous = $freq{$word} unless $freq{$word} == $previous;
    $eol = "\n";
    print " $word";
}
print "\n";
