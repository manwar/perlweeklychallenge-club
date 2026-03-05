#!/usr/bin/env perl

use Modern::Perl;

my $words = "@ARGV";
my @words = split /,/, $words;

my $count = [];
for my $i (0..1) {
    for my $word (split ' ', $words[$i]) {
        $count->[$i]{$word}++;
    }
}

my $count_same = 0;
for my $word (split ' ', @words[0..1]) {
    $count_same++ if ($count->[0]{$word}//0)==1 && ($count->[1]{$word}//0)==1;
}

say $count_same;
