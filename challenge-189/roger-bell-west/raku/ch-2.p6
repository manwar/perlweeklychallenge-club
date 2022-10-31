#! /usr/bin/perl6

use Test;

plan 5;

is-deeply(arraydegree([1, 3, 3, 2]), [3, 3], 'example 1');
is-deeply(arraydegree([1, 2, 1, 3]), [1, 2, 1], 'example 2');
is-deeply(arraydegree([1, 3, 2, 1, 2]), [2, 1, 2], 'example 3');
is-deeply(arraydegree([1, 1, 2, 3, 2]), [1, 1], 'example 4');
is-deeply(arraydegree([2, 1, 2, 1, 1]), [1, 2, 1, 1], 'example 5');

sub arraydegree(@a) {
    my %f;
    map {%f{$_}++},@a;
    my $degree = max(values %f);
    my %inverse;
    for (0..@a.end) -> $i {
        if (%inverse{@a[$i]}:exists) {
            %inverse{@a[$i]}[1] = $i;
        } else {
            %inverse{@a[$i]} = [$i, $i];
        }
    }
    my $minlen = 1 + @a.elems;
    my @se;
    for (%f.keys.grep({%f{$_} == $degree})) -> $n {
        my $ll = 1 + %inverse{$n}[1] - %inverse{$n}[0];
        if ($ll < $minlen) {
            $minlen = $ll;
            @se = (%inverse{$n}[0], %inverse{$n}[1]);
        }
    }
    return [@a[@se[0]..@se[1]]];
}
