#! /usr/bin/perl6

use Test;

plan 3;

is-deeply(movezero([1, 0, 3, 0, 0, 5]), [1, 3, 5, 0, 0, 0], 'example 1');
is-deeply(movezero([1, 6, 4]), [1, 6, 4], 'example 2');
is-deeply(movezero([0, 1, 0, 2, 0]), [1, 2, 0, 0, 0], 'example 3');

sub movezero(@l) {
    my @o = grep {$_ != 0}, @l;
    @o.push(((0) xx (@l.elems - @o.elems)).Slip);
    return @o;
}
