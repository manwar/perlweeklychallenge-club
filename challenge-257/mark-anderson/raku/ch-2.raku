#!/usr/bin/env raku
use Test;

ok  reduced-row-echelon([1, 0, 0, 1],
                        [0, 1, 0, 2],
                        [0, 0, 1, 3]);

nok reduced-row-echelon([1, 1, 0],
                        [0, 1, 0],
                        [0, 0, 0]);

ok  reduced-row-echelon([0, 1,-2, 0, 1],
                        [0, 0, 0, 1, 3],
                        [0, 0, 0, 0, 0],
                        [0, 0, 0, 0, 0]);

ok  reduced-row-echelon([1, 0, 0, 4],
                        [0, 1, 0, 7],
                        [0, 0, 1,-1]);

nok reduced-row-echelon([0, 1,-2, 0, 1],
                        [0, 0, 0, 0, 0],
                        [0, 0, 0, 1, 3],
                        [0, 0, 0, 0, 0]);

nok reduced-row-echelon([0, 1, 0],
                        [1, 0, 0],
                        [0, 0, 0]);

nok reduced-row-echelon([4, 0, 0, 0],
                        [0, 1, 0, 7],
                        [0, 0, 1,-1]);

sub reduced-row-echelon(+@m)
{
    # the first non-zero number in a row is the pivot
    my @pivots = @m>>.first(*.so, :kv);

    # the first row that is all zeroes
    my $k = @pivots.first(*.not, :k);

    # all 0 rows are grouped at the bottom
    if $k 
    { 
        return False unless @pivots[$k..*].all eqv Any; 
        @pivots = @pivots[^$k]
    }

    # all pivots == 1 
    return False unless so @pivots>>[1].all == 1;

    # pivots go from top-left to bottom-right
    return False unless [<] @pivots>>[0];

    # pivot columns are all 0 (except for the 1)
    return all(([Z] @m[^@pivots])[@pivots>>[0]]>>.sum) == 1
}
