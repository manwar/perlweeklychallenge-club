#!/usr/bin/env perl

use Modern::Perl;

@ARGV==2 or die "usage: $0 'sentence' keys\n";
my @words = split ' ', $ARGV[0];
my $keys = $ARGV[1];
if ($keys eq '') {
    say scalar(@words);
}
else {
    my @can_type = grep {! /[$keys]/i} @words;
    say scalar(@can_type);
}
