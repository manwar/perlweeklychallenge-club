#! /usr/bin/raku

use Test;

plan 5;

is-deeply(matchstring(['cat', 'cats', 'dog', 'dogcat', 'dogcat', 'rat', 'ratcatdogcat']), ['cat', 'dog', 'dogcat', 'rat'], 'example 1');
is-deeply(matchstring(['hello', 'hell', 'world', 'wor', 'ellow', 'elloworld']), ['hell', 'world', 'wor', 'ellow'], 'example 2');
is-deeply(matchstring(['a', 'aa', 'aaa', 'aaaa']), ['a', 'aa', 'aaa'], 'example 3');
is-deeply(matchstring(['flower', 'flow', 'flight', 'fl', 'fli', 'ig', 'ght']), ['flow', 'fl', 'fli', 'ig', 'ght'], 'example 4');
is-deeply(matchstring(['car', 'carpet', 'carpenter', 'pet', 'enter', 'pen', 'pent']), ['car', 'pet', 'enter', 'pen', 'pent'], 'example 5');

sub matchstring(@a) {
    my @out;
    my $s = SetHash.new;
    for @a -> $x {
        unless ($s{$x}:exists) {
            for @a -> $y {
                if ($y.chars > $x.chars) {
                    my $p = index($y, $x);
                    with ($p) {
                        @out.push($x);
                        last;
                    }
                }
            }
            $s{$x}++;
        }
    }
    @out;
}
