#/usr/bin/env raku

use Test;
plan 4;

is-deeply consecutive-arrays(1, 2, 3, 6, 7, 8, 9), ([1, 2, 3], [6, 7, 8, 9]);
is-deeply consecutive-arrays(11, 12, 14, 17, 18, 19),  ([11, 12], [14], [17, 18, 19]);
is-deeply consecutive-arrays(2, 4, 6, 8), ([2], [4], [6], [8]);
is-deeply consecutive-arrays(1, 2, 3, 4, 5), ([1, 2, 3, 4, 5],);

sub consecutive-arrays(**@N)
{
    my $i;

    my @consecutives = gather for @N.rotor(2 => -1, :partial)
    {
        $i++;

        if .head !== .tail - 1
        {
            take $i;
            $i = 0;
        }
    }

    @N.rotor(@consecutives)>>.Array;
}
