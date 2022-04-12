#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab
use v6.d;

use Test;
constant TEST = True;

#2 Find the Equilibrium Index which indexes the element between the two
#     sub arrays that sum to equal values, return -1 if none such.

if TEST {
    my @t =
         3 => [1, 3, 5, 7, 9 ],
        -1 => [1, 2, 3, 4, 5 ],
         1 => [ 2, 4, 2 ],
        -1 => [,],
        -1 => [ 1 ],
        -1 => [ 1, 1],
        -1 => [ 1, 1, 1, 1 ],
        -1 => [ 1, 7, 10, 40 ],
         2 => [ 1, 1, 1, 1, 1 ],
         1 => [ 4, 1, 1, 1, 2 ],
         3 => [ 1, 1, 2, 1, 4 ],
         2 => [ -1, 10, 1, 4, 5 ],
         1 => [ 10, -1, 1, 5, 4 ],   # dual solution
         2 => [ 4, 5, 1, -1, 10 ],   # dual solution
         2 => [ 5, 4, 1, 10, -1 ],
    ;

   plan @t.elems;

    for @t -> (:$key, :$value) {
        my $got = find-equilibrium-index ( $value.Array);
        is $key, $got, "f-e-i: [ $value ] s/b $key";
    }
    exit;
}

sub find-equilibrium-index ( @ary --> Int ) {
    return -1 if @ary.end < 2;
    for 1..@ary.end-1 -> $i {
        if ([+] @ary[0..($i - 1)]) == ([+] @ary[ ($i + 1) .. @ary.end ]) {
            return $i;
        }
    }
    -1
}

sub MAIN( @a = [ 1, 1, 1, 1, 7, 10, 40, 105, 59, 2] ) {
    print 'Input: @n = (', @a, ")\nOutput: ";
    my $flag = find-equilibrium-index ( @a );
    print "$flag ", $flag == -1 ?? 'as no Equilibrium Index found.' !! '';
}

done-testing;

