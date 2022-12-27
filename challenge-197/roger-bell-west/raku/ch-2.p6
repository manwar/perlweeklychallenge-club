#! /usr/bin/perl6

use Test;

plan 8;

is(is_wigglesorted([1,5,1,1,6,4]), False, 'example 1');
is(is_wigglesorted([1,6,1,5,1,4]), True, 'example 2');
is(is_wigglesorted([1,3,2,2,3,1]), False, 'example 3');
is(is_wigglesorted([2,3,1,3,1,2]), True, 'example 4');
is(is_wigglesorted([1,3,2,2,3,1]), False, 'example 5');
is(is_wigglesorted(wigglesort([1,5,1,1,6,4])), True, 'example 6');
is(is_wigglesorted(wigglesort([1,3,2,2,3,1])), True, 'example 7');
is(is_wigglesorted(wigglesort([1,3,2,2,2,3,1])), True, 'example 8');

sub is_wigglesorted(@l) {
    for (0..@l.elems-2) -> $i {
        if ($i % 2 == 0) {
            if (@l[$i] >= @l[$i+1]) {
                return False;
            }
        } else {
            if (@l[$i] <= @l[$i+1]) {
                return False;
            }
        }
    }
    return True;
}

sub wigglesort(@l) {
    my @s = sort @l;
    my $le = @s.elems;
    my $p = floor($le / 2);
    my @a = @s[0 .. $p - 1];
    my @b = @s[$p .. @s.elems - 1];
    my $i = 0;
    my @o;
    if ($le % 2 == 1) {
        @o.push(@s[$p]);
        @b = @s[$p + 1 .. @s.elems - 1];
        $i = 1;
    }
    for ($i .. @s.elems - 1) -> $j {
        if ($j % 2 == 0) {
            @o.push(@a.pop);
        } else {
            @o.push(@b.pop);
        }
    }
    return @o;
}
