#! /usr/bin/raku

use Test;

plan 2;

is(deleteandearn([3, 4, 2]), 6, 'example 1');
is(deleteandearn([2, 2, 3, 3, 3, 4]), 9, 'example 2');

sub deleteandearn(@a) {
    my %ct;
    @a.map({%ct{$_}++});
    my $mx = 0;
    my @stack;
    @stack.push([%ct, 0]);
    while (@stack.elems > 0) {
        my @c = (@stack.pop).flat;
        if @c[0].elems == 0 {
            $mx = max($mx, @c[1]);
        } else {
            for @c[0].keys -> $d {
                my %cc = @c[0].clone;
                %cc{$d} -= 1;
                if (%cc{$d} == 0) {
                    %cc{$d}:delete;
                }
                %cc{$d - 1}:delete;
                %cc{$d + 1}:delete;
                @stack.push([%cc, @c[1] + $d]);
            }
        }
    }
    $mx;
}
