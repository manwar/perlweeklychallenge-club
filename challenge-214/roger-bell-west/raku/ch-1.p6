#! /usr/bin/raku

use Test;

plan 4;

is-deeply(rankscore([1, 2, 4, 3, 5]), ['5', '4', 'S', 'B', 'G'], 'example 1');
is-deeply(rankscore([8, 5, 6, 7, 4]), ['G', '4', 'B', 'S', '5'], 'example 2');
is-deeply(rankscore([3, 5, 4, 2]), ['B', 'G', 'S', '4'], 'example 3');
is-deeply(rankscore([2, 5, 2, 1, 7, 5, 1]), ['4=', 'S=', '4=', '6=', 'G', 'S=', '6='], 'example 4');

sub rankscore(@a) {
    my %av;
    for @a -> $s {
        %av{$s}++;
    }
    my $rank = 1;
    my %tab;
    for (sort {$^b <=> $^a}, %av.keys) -> $k {
        my $siz = %av{$k};
        my $r;
        if ($rank <= 3) {
            $r = ['G', 'S', 'B'][$rank - 1];
        } else {
            $r = '' ~ $rank;
        }
        if ($siz > 1) {
            $r ~= "=";
        }
        %tab{$k} = $r;
        $rank += $siz;
    }
    return [map {%tab{$_}}, @a];
}
