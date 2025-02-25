#! /usr/bin/raku

use Test;

plan 3;

is-deeply(nextpermutation([1, 2, 3]), [1, 3, 2], 'example 1');
is-deeply(nextpermutation([2, 1, 3]), [2, 3, 1], 'example 2');
is-deeply(nextpermutation([3, 1, 2]), [3, 2, 1], 'example 3');

sub nextpermutation(@a) {
    my @b = @a.sort({$^a <=> $^b});
    my $flag = False;
    my @out;
    for @b.permutations -> @px {
        if (@out.elems == 0) {
            @out = @px.clone;
        }
        if ($flag) {
            @out = @px.clone;
            last;
        }
        if Array(@px) eqv @a {
            $flag = True;
        }
    }
    @out;
}
