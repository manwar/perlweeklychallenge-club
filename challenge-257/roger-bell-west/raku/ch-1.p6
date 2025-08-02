#! /usr/bin/raku

use Test;

plan 4;

is-deeply(smallerthancurrent([5, 2, 1, 6]), [2, 1, 0, 3], 'example 1');
is-deeply(smallerthancurrent([1, 2, 0, 3]), [1, 2, 0, 3], 'example 2');
is-deeply(smallerthancurrent([0, 1]), [0, 1], 'example 3');
is-deeply(smallerthancurrent([9, 4, 9, 2]), [2, 1, 2, 0], 'example 4');

sub smallerthancurrent(@a) {
    my %l;
    my @s = @a.sort({$^a <=> $^b});
    for (0..@s.end) -> $i {
        my $n = @s[$i];
        unless (%l{$n}:exists) {
            %l{$n} = $i;
        }
    }
    return Array(@a.map({%l{$_}}));
}
