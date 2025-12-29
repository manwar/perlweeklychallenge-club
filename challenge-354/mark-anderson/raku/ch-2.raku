#!/usr/bin/env raku
use Test;

is-deeply shift-grid([<1 2 3>,
                      <4 5 6>,
                      <7 8 9>], 1), 
  
                     (<9 1 2>,
                      <3 4 5>, 
                      <6 7 8>);

is-deeply shift-grid([<10 20>,
                      <30 40>], 1),
          
                     (<40 10>, 
                      <20 30>);

is-deeply shift-grid([<1 2>,
                      <3 4>,
                      <5 6>], 1),

                     (<6 1>,
                      <2 3>,
                      <4 5>);

is-deeply shift-grid([<1 2 3>,
                      <4 5 6>], 5),

                     (<2 3 4>,
                      <5 6 1>);

is-deeply shift-grid([<1 2 3 4>,], 1),

                     (<4 1 2 3>,);

sub shift-grid(@m, $k)
{
    my $e = @m.head.elems;
    @m   .= flat(:hammer);
    @m.rotate(-$k mod @m).batch($e)
}
