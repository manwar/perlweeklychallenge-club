#!/usr/bin/env raku
use Test;

is-deeply binary-prefix(<1 0 1>), (False,True,True);
is-deeply binary-prefix(<1 1 0>), (False,True,False);
is-deeply binary-prefix(<1 1 1 1 0 1 0 0 0 0 1 0 1 0 0 1 0 0 0 1>),
                                  (False,True,True,False,False,True,False,
                                   False,False,False,False,False,False,
                                   False,False,False,False,False,False,True);

sub binary-prefix(@bits)
{
    ([\~] @bits).map({ .parse-base(2).is-prime })
}
