#! /usr/bin/raku

use Test;

plan 3;

is-deeply(leftrightsumdiff([10, 4, 8, 3]), [15, 1, 11, 22], 'example 1');
is-deeply(leftrightsumdiff([1]), [0], 'example 2');
is-deeply(leftrightsumdiff([1, 2, 3, 4, 5]), [14, 11, 6, 1, 10], 'example 3');

sub leftrightsumdiff(@a) {
    my $al = @a.end;
    my @left = [0];
    my @right = [0];
    for 0 .. $al-1 -> $i {
        @left.push(@left[$i] + @a[$i]);
        @right.push(@right[$i] + @a[$al - $i]);
    }
    return Array(zip(@left, @right.reverse).map({abs($_[0] - $_[1])}));
}
