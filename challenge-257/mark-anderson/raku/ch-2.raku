#!/usr/bin/env raku
use Test;

ok  echelon([1,0,0,1],
            [0,1,0,2],
            [0,0,1,3]);

nok echelon([1, 1, 0],
            [0, 1, 0],
            [0, 0, 0]);

ok  echelon([0, 1,-2, 0, 1],
            [0, 0, 0, 1, 3],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0]);

ok  echelon([1, 0, 0, 4],
            [0, 1, 0, 7],
            [0, 0, 1,-1]);

nok echelon([0, 1,-2, 0, 1],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 1, 3],
            [0, 0, 0, 0, 0]);

nok echelon([0, 1, 0],
            [1, 0, 0],
            [0, 0, 0]);

nok echelon([4, 0, 0, 0],
            [0, 1, 0, 7],
            [0, 0, 1,-1]);

sub echelon(+@m)
{
    my @first = @m>>.first(*.so, :kv);
    my $k = @first.first(*.so.not, :k);

    # if rows are all 0 then they are grouped at the bottom
    if $k { return False unless so @first[$k..*].all eqv (Any) }

    my @non-zeroes = quietly @first[^$k] || @first;

    # first non-zero number in rows (without all zeroes) is a 1
    return False unless so @non-zeroes>>.[1].all == 1;

    # 1 is to the right of the 1 in the row above
    return False unless [<] @non-zeroes>>[0];

    # leading zero cols are all 0 (except for the 1)
    return all @non-zeroes>>[0].map({
                                        all @m[*;$_].sum == 1,
                                        all(@m[*;$_].Bag.keys) ~~ 0..1 
                                    })
}
