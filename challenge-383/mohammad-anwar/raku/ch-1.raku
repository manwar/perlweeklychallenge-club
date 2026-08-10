#!/usr/bin/env raku

use Test;

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
            [ $["perl4", "perl5", "raku"] ]
        ],
        out => "true"
    },
    {
        in => [
            ["enjoy", "challenge"],
            ["love", "weekly", "challenge"],
            [ $["enjoy", "love"] ]
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

for @examples -> $_ {
    is similar_list(|$_<in>), $_<out>;
}

done-testing;

sub similar_list ($list1, $list2, $list3) {
    return "false" unless $list1.elems == $list2.elems;

    my @groups = $list3[0] ~~ Str ?? [ $list3 ] !! @$list3;

    my %canon;
    for @groups -> $group {
        my $rep = $group[0];
        for $group.flat -> $_ {
            %canon{$_} = $rep;
        }
    }

    for 0 ..^ $list1.elems -> $i {
        my $a = %canon{$list1[$i]} // $list1[$i];
        my $b = %canon{$list2[$i]} // $list2[$i];
        return "false" if $a ne $b;
    }

    return "true";
}
