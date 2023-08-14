#!/usr/bin/perl
use v5.36;

my $deletions = 0;
foreach (@ARGV) {
    my @sorted = sort(split //, $_);
    $deletions++ if (fc($_) ne fc(join('', @sorted)) && fc($_) ne fc(join('', reverse @sorted)));
}
say $deletions // 0;
