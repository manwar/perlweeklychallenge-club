#! /usr/bin/raku

use Test;

plan 5;

is-deeply(minabsdiff([4, 2, 1, 3]), [[1, 2], [2, 3], [3, 4]], 'example 1');
is-deeply(minabsdiff([10, 100, 20, 30]), [[10, 20], [20, 30]], 'example 2');
is-deeply(minabsdiff([-5, -2, 0, 3]), [[-2, 0],], 'example 3');
is-deeply(minabsdiff([8, 1, 15, 3]), [[1, 3],], 'example 4');
is-deeply(minabsdiff([12, 5, 9, 1, 15]), [[9, 12], [12, 15]], 'example 5');

sub minabsdiff(@a) {
    my @b = @a.sort({$^a <=> $^b});
    my @out;
    my $mindiff = 1 + @b[*-1] - @b[0];
    for @b.rotor(2 => -1) -> @c {
        my $d = @c[1] - @c[0];
        if ($d < $mindiff) {
            @out = [];
            $mindiff = $d;
        }
        if ($d == $mindiff) {
            @out.push(@c.Array);
        }
    }
    @out;
}
