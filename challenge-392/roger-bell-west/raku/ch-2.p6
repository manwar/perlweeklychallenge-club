#! /usr/bin/raku

use Test;

plan 5;

is(wordslengthproduct(['a', 'ab', 'abc', 'd', 'de', 'def']), 9, 'example 1');
is(wordslengthproduct(['a', 'aa', 'aaa', 'aaaa']), 0, 'example 2');
is(wordslengthproduct(['meet', 'app', 'code', 'sky', 'bold']), 16, 'example 3');
is(wordslengthproduct(['a', 'ab', 'abc', 'abcd', 'efghi']), 20, 'example 4');
is(wordslengthproduct(['xyz', 'w', 'abcdefg', 'hij']), 21, 'example 5');

sub wordslengthproduct(@a) {
    my @ws = @a.map({Set.new($_.comb)});
    my $mx = 0;
    for 0 .. @ws.end - 1 -> $i {
        for $i + 1 .. @ws.end -> $j {
            if (@ws[$i] (&) @ws[$j]).elems == 0 {
                $mx = max($mx, @a[$i].chars * @a[$j].chars);
            }
        }
    }
    $mx;
}
