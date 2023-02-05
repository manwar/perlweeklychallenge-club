#! /usr/bin/raku

use Test;

#plan 5;
plan 5;

is-deeply(widestvalley([1, 5, 5, 2, 8]), [5, 5, 2, 8], 'example 1');
is-deeply(widestvalley([2, 6, 8, 5]), [2, 6, 8], 'example 2');
is-deeply(widestvalley([9, 8, 13, 13, 2, 2, 15, 17]), [13, 13, 2, 2, 15, 17], 'example 3');
is-deeply(widestvalley([2, 1, 2, 1, 3]), [2, 1, 2], 'example 4');
is-deeply(widestvalley([1, 3, 3, 2, 1, 2, 3, 3, 2]), [3, 3, 2, 1, 2, 3, 3], 'example 5');

sub widestvalley(@a) {
    my @av;
    my @ac;
    my $l = -1;
    for (@a) -> $v {
        if ($v == $l) {
            @ac[*-1]++;
        } else {
            @av.push($v);
            @ac.push(1);
            $l = $v;
        }
    }
    my @s;
    my @e;
    my $c = 0;
    for (0..@av.end) -> $i {
        if ($i == 0 || $i == @av.end || (@av[$i - 1] < @av[$i] && @av[$i] > @av[$i + 1])) {
            @s.push($c);
            @e.push($c + @ac[$i] - 1);
        }
        $c += @ac[$i];
    }
    my @out;
    for (0..@s.end - 1) -> $i {
        if (@e[$i + 1] - @s[$i] + 1 > @out.elems) {
            @out = @a[@s[$i]..@e[$i + 1]];
        }
    }
    return @out;
}
