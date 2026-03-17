#!/usr/bin/env perl

use Modern::Perl;

my($banned, @paragraph) = @ARGV;
my %count;
my @words =
    map { $_->[0] }
    sort { $b->[1] <=> $a->[1] }
    map { [$_, $count{$_}++] }
    grep { lc($banned) ne lc($_) }
    split /\W/, "@paragraph";
say $words[0];
