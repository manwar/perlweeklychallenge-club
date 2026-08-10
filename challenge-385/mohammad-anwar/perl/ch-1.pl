#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

my @examples = (
    { in => ["apple banana apple", "banana orange"],     out => "orange" },
    { in => ["cat dog", "bird fish"],                    out => "bird cat dog fish" },
    { in => ["the quick brown fox", "the quick"],        out => "brown fox" },
    { in => ["hello", "hello"],                          out => "" },
    { in => ["blue blue red", "red green green yellow"], out => "yellow" },
);

is uncommon_words(@{$_->{in}}), $_->{out} foreach @examples;

done_testing;

sub uncommon_words {
    my ($s1, $s2) = @_;

    my %count;
    $count{$_}++ for split ' ', "$s1 $s2";
    return join ' ', sort grep { $count{$_} == 1 } keys %count;
}
