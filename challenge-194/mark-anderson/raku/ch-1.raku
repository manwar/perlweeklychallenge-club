#!/usr/bin/env raku
use Test;

is digital-clock('?5:00'), 1;
is digital-clock('?3:00'), 2;
is digital-clock('1?:00'), 9;
is digital-clock('2?:00'), 3;
is digital-clock('12:?5'), 5;
is digital-clock('12:5?'), 9;

sub digital-clock($t)
{
    return do given $t.index('?')
    {
        when 4 { 9 }
        when 3 { 5 }
        default 
        {
            my $d = $t ~~ m:1st/\d/;
            when 1  { $d < 2 ?? 9 !! 3 }
            default { $d < 4 ?? 2 !! 1 }
        }
    }
}
