#!/usr/bin/env raku
use Math::Prime::Util:from<Perl5> <numtoperm>;
use Test;

# I don't know why this is so slow - it seems like it should be fast :-(

is cute-list(2),  2;
is cute-list(3),  3;
is cute-list(4),  8;
is cute-list(5),  10;
is cute-list(10), 700;

sub cute-list($n)
{
    my ($p, $ctr) = (0, 0);

    LABEL: while $p < [*] 1..$n
    {
        my @perm = numtoperm($n, $p) >>+>> 1;

        for (1..$n).rotor(2 => -1) 
        {
            unless (@perm[.head] %% .tail or .tail %% @perm[.head])
            {
                $p += [*] 1..$n-.tail;
                next LABEL
            }
        }

        ($p, $ctr) >>+=>> 1
    }

    $ctr
}
