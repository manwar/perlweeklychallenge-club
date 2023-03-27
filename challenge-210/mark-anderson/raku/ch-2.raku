#!/usr/bin/env raku
use Test;

is-deeply number-collisions(-2,-1,-3,1,2,3), 
                           (-2,-1,-3,1,2,3);

is-deeply number-collisions(1,2,3,-3,-1), 
                           (1,2);

is-deeply number-collisions(-2,4,5,-3,-1,9,-8), 
                           (-2,4,5,9);

is-deeply number-collisions(12,43,-76,-8,88,-88,-19,11,2,-1,0,-99),
                           (-76,-8,-19,-99);

is-deeply number-collisions(99,12,43,-76,-8,88,-88,-19,11,2,-1,0,-99),
                           ();

is-deeply number-collisions(12,43,-76,-8,88,-88,-19,11,2,-1,0),
                           (-76,-8,-19,11,2,0);

sub number-collisions(*@a)
{
    given $_ = @a.join(' ')  
    {
        while / <!after \-\d*> (\d+) \s (\-\d+) / 
        {
            when $0 < $1.abs { .substr-rw($0.from, $0.to.succ - $0.from) = Empty }
            when $0 > $1.abs { .substr-rw($1.from, $1.to.succ - $1.from) = Empty }
            default          { .substr-rw($0.from, $1.to.succ - $0.from) = Empty }
        }

        .comb(/ \-? \d+ /)>>.Int
    }
}
