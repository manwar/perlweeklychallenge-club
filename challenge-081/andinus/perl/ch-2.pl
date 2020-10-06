#!/usr/bin/perl

use strict;
use warnings;

use Path::Tiny;

die "usage: ./ch-1.pl <file path>"
    unless scalar @ARGV == 1;

my $file = path(shift @ARGV)->slurp;

$file =~ s/(--|'s)/ /g;
$file =~ s/[."(),]+/ /g;
$file =~ s/  / /g;
$file =~ s/\n/ /g;

my %words;
foreach my $word (split / /, $file) {
    $words{$word} = 1 and next unless exists $words{$word};
    $words{$word}++;
}

my %out;
foreach my $word (sort keys %words) {
    my $freq = $words{$word};
    push @{$out{$freq}}, $word;
}

foreach my $freq (sort { $a <=> $b} keys %out) {
    print "$freq ", join(' ', @{$out{$freq}}, "\n");
}
