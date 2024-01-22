#!/usr/bin/env raku
use Test;

is-deeply weakest-rows([
                          [1, 1, 0, 0, 0],
                          [1, 1, 1, 1, 0],
                          [1, 0, 0, 0, 0],
                          [1, 1, 0, 0, 0],
                          [1, 1, 1, 1, 1]
                       ]),
                          (2, 0, 3, 1, 4);

is-deeply weakest-rows([
                           [1, 0, 0, 0],
                           [1, 1, 1, 1],
                           [1, 0, 0, 0],
                           [1, 0, 0, 0]
                       ]),
                           (0, 2, 3, 1);

is-deeply weakest-rows([
                          [1, 1, 0, 0, 0],
                          [1, 1, 1, 1, 0],
                          [0, 0, 0, 0, 0],
                          [1, 1, 0, 0, 0],
                          [1, 1, 1, 1, 1]
                       ]),
                          (2, 0, 3, 1, 4);

sub weakest-rows($m)
{
    $m.map({ .first(0, :k) // ∞ }).antipairs.sort>>.value
}
