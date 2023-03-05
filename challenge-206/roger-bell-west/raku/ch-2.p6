#! /usr/bin/raku

use Test;

plan 2;

is(arraypairing([1, 2, 3, 4]), 4, 'example 1');
is(arraypairing([0, 2, 1, 3]), 2, 'example 2');

sub arraypairing(@n) {
    my $nl = @n.elems;
    if ($nl % 2 == 1) {
        return 0;
    }
    my $hl = $nl div 2;
    my @out;
    for [0 .. $nl-1].combinations($hl) -> @px {
        my @pa = map {@n[$_]},@px;
        my $ps = @px.Set;
        my @pb = map {@n[$_]}, grep {$ps{$_}:!exists}, (0 .. $nl-1);
        for @pa.permutations -> @pp {
            my $s = 0;
            for (0 .. $hl-1) -> $i {
                $s += min(@pp[$i], @pb[$i]);
            }
            @out.push($s);
        }
    }
    return max(@out);
}
