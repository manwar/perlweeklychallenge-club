#!/usr/bin/env perl

use v5.38;
use Test::More;
use List::Util qw(sum);

my @examples = (
    { in => ["ab","bc","cd","zy"],         out => "zy"   },
    { in => ["cba","fed","azy"],           out => "azy"  },
    { in => ["pop","ada","beb","cfc"],     out => "pop"  },
    { in => ["aaaa","zzzz","mmmm","aaba"], out => "aaba" },
    { in => ["aceg","bdfh","cegi","azbz"], out => "azbz" },
);

is_deeply odd_one_out(@{$_->{in}}), $_->{out} foreach @examples;

done_testing;

sub odd_one_out(@words) {
    my @diff_keys = map {
        my @c = map { ord } split //;
        join ',', map { $c[$_ + 1] - $c[$_] } 0 .. $#c - 1;
    } @words;

    my %count;
    $count{$_}++ for @diff_keys;

    my ($unique_key) = grep { $count{$_} == 1 } keys %count;
    my ($idx) = grep { $diff_keys[$_] eq $unique_key } 0 .. $#words;

    return $words[$idx];
}
