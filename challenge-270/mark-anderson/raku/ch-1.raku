#!/usr/bin/env raku
use Test;

is special-positions([ 
                         [1,0,0],
                         [0,0,1],
                         [1,0,0],
                     ]),               1;

is special-positions([ 
                         [1,0,0],
                         [0,1,0],
                         [0,0,1],
                     ]),               3;

sub special-positions(@m)
{
   my @ones = (^@m X ^@m[0]).grep({ @m[.[0];.[1]] });

   +  @ones.grep({ all .[0] == one(@ones>>.[0]), 
                       .[1] == one(@ones>>.[1])
                 })
}
