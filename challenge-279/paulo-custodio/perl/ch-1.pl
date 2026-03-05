#!/usr/bin/env perl

use Modern::Perl;

@ARGV > 2 or die "Usage: $0 LETTTERS WEIGHTS...\n";
my($letters, @weights) = @ARGV;
my @letters = split //, $letters;
say join('',
        map {$_->[0]}
        sort {$a->[1] <=> $b->[1]}
        map {[$letters[$_], $weights[$_]]} 0..$#letters);
