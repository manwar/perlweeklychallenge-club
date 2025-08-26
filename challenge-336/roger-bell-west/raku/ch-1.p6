#! /usr/bin/raku

use Test;

plan 5;

is(equalgroup([1, 1, 2, 2, 2, 2]), True, 'example 1');
is(equalgroup([1, 1, 1, 2, 2, 2, 3, 3]), False, 'example 2');
is(equalgroup([5, 5, 5, 5, 5, 5, 7, 7, 7, 7, 7, 7]), True, 'example 3');
is(equalgroup([1, 2, 3, 4]), False, 'example 4');
is(equalgroup([8, 8, 9, 9, 10, 10, 11, 11]), True, 'example 5');

sub equalgroup(@a) {
    my %s;
    @a.map({%s{$_}++});
    my @v = %s.values.unique.sort;
    my $l = @v[0];
    if ($l < 2) {
        return False;
    }
    for (2 .. $l) -> $t {
        if (@v.all % $t == 0) {
            return True;
        }
    }
    False;
}
