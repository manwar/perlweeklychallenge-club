#!/usr/bin/env raku
use Test;

is making-change(9),   2;
is making-change(15),  6;
is making-change(100), 292;

is making-change-polymod(9),   2;
is making-change-polymod(15),  6;
is making-change-polymod(100), 292;

sub making-change($amount)
{
    .elems given gather loop (my $n = 0; $n <= $amount; $n += 5)
    {
        loop (my $d = 0; $d <= $amount; $d += 10)
        {
            last if $n + $d > $amount; 
    
            loop (my $q = 0; $q <= $amount; $q += 25)
            {
                last if $d + $q > $amount;
                last if $n + $d + $q > $amount;
    
                loop (my $h = 0; $h <= $amount; $h += 50)
                {
                    last if $q + $h > $amount;
                    last if $d + $q + $h > $amount;
                    last if $n + $d + $q + $h > $amount;
                   .take
                }
            }
        }
    }
}

# This sub is like the one above without the short circuiting.
sub making-change-polymod($amount)
{
    1 + .elems given do for 1..3464 
    {   
        my $p = .polymod(21,11,5,3).List;
        $p if ([+] $p.head(4) Z* (5,10,25,50)) <= $amount
    }
}
