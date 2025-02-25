#! /usr/bin/raku

use Test;

plan 2;

is-deeply(threedigitseven([2, 1, 3, 0]), [102, 120, 130, 132, 210, 230, 302, 310, 312, 320], 'example 1');
is-deeply(threedigitseven([2, 2, 8, 8, 2]), [222, 228, 282, 288, 822, 828, 882], 'example 2');

sub threedigitseven(@a) {
    my %s = SetHash.new;
    for 1 ..^ (1 +< @a.elems) -> $mask {
        my @pl;
        for @a.kv -> $k, $v {
            if (1 +< $k +& $mask > 0) {
                @pl.push($v);
            }
        }
        for @pl.permutations -> @px {
            my $c = @px.join('');
            if ($c >= 100 && $c <= 999 && $c % 2 == 0) {
                %s{Int($c)}++;
            }
        }
    }
    [%s.keys.sort({$^a <=> $^b}).map({Int($_)})];
}
