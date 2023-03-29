#! /usr/bin/raku

use Test;

plan 3;

is-deeply(numbercollision([2, 3, -1]), [2, 3], 'example 1');
is-deeply(numbercollision([3, 2, -4]), [-4], 'example 2');
is-deeply(numbercollision([1, -1]), [], 'example 3');

sub numbercollision(@aa) {
    my @a = @aa;
    my $dirty = True;
    while ($dirty) {
        my @b;
        $dirty = False;
        my $i = 0;
        while ($i <= @a.end) {
            if ($i < @a.end && @a[$i] > 0 && @a[$i + 1] < 0 ) {
                my $ab = abs(@a[$i+1]);
                if (@a[$i] > $ab) {
                    @b.push(@a[$i]);
                } elsif (@a[$i] < $ab) {
                    @b.push(@a[$i + 1]);
                }
                $i+=2;
                $dirty = True;
            } else {
                @b.push(@a[$i]);
                $i++;
            }
        }
        @a = @b;
    }
    return @a;
}
