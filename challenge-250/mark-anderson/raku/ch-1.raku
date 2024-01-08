#!/usr/bin/env raku
use Test;

is smallest-index(<0 1 2>),                                                        0;
is smallest-index(<4 3 2 1>),                                                      2;
is smallest-index(<1 2 3 4 5 6 7 8 9 0>),                                         -1;
is smallest-index(<6 4 4 2 0 7 9 8 9 6 4 6 1 4 9 3 5 2 2 1 3 8 5 3 1 3 6 0 1 7>), 23;

sub smallest-index(@i)
{
    (@i Z== flat(^10 xx *)).first({ $_ }, :k) // -1
}
