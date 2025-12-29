#!/usr/bin/env raku
use Test;

is-deeply min-abs-diff(<4 2 1 3>),      [<1 2>, <2 3>, <3 4>];
is-deeply min-abs-diff(<10 100 20 30>), [<10 20>, <20 30>];
is-deeply min-abs-diff(<-5 -2 0 3>),    [<-2 0>,];
is-deeply min-abs-diff(<8 1 15 3>),     [<1 3>,];
is-deeply min-abs-diff(<12 5 9 1 15>),  [<9 12>, <12 15>];

sub min-abs-diff(@ints)
{
    @ints.sort
         .rotor(2 => -1)
         .classify({ .[1] - .[0] })
         .min
         .value
}
