#!/usr/bin/env perl

use strict;
use warnings;

use Test::More;

my @examples = (
    {
        in => [
            ["great", "acting"],
            ["fine", "drama"],
            [["great", "fine"], ["acting", "drama"]]
        ],
        out => "true"
    },
    {
        in => [
            ["apple", "pie"],
            ["banana", "pie"],
            [["apple", "peach"], ["peach", "banana"]]
        ],
        out => "false"
    },
    {
        in => [
            ["perl4", "python"],
            ["raku", "python"],
            [["perl4", "perl5", "raku"]]
        ],
        out => "true"
    },
    {
        in => [
            ["enjoy", "challenge"],
            ["love", "weekly", "challenge"],
            [["enjoy", "love"]]
        ],
        out => "false"
    },
    {
        in => [
            ["fast", "car"],
            ["quick", "vehicle"],
            [["quick", "fast"], ["vehicle", "car"]]
        ],
        out => "true"
    },
);

is similar_list(@{$_->{in}}), $_->{out} foreach @examples;

done_testing;

sub similar_list {
    my ($list1, $list2, $list3) = @_;
    return "false" unless @$list1 == @$list2;

    my %canon;
    for my $group (@$list3) {
        my $rep = $group->[0];
        $canon{$_} = $rep foreach @$group;
    }

    foreach my $i (0..$#$list1) {
        my $a = $canon{$list1->[$i]} // $list1->[$i];
        my $b = $canon{$list2->[$i]} // $list2->[$i];
        return "false" if $a ne $b;
    }

    return "true";
}
