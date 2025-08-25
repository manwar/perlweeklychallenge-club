#!/usr/bin/env raku
use Test;

is final-score(< 5 2 C D + >),                   30;
is final-score(< 5 -2 4 C D 9 + + >),            27;
is final-score(< 7 D D C + 3 >),                 45;
is final-score(< -5 -10 + D C + >),             -55;
is final-score(<     3 6 + D C 8 + D -2 C + >), 128;
is final-score(< D C 3 6 + D C 8 + D -2 C + >), 128;
is final-score(< C D 3 6 + D C 8 + D -2 C + >), 128;
is final-score(< + C 3 6 + D C 8 + D -2 C + >), 128;

sub final-score(@scores)
{
    my @stack;

    for @scores 
    { 
        when Int {         @stack.push: $_                 }
        when 'C' {         @stack.pop                      }
        when 'D' { quietly @stack.push: @stack.tail * 2    } 
        default  {         @stack.push: @stack.tail(2).sum } 
    }

    @stack.sum
}
