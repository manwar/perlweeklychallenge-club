#!/usr/bin/env raku
use Test;

ok  exact-change(5,5,5,10,20);
nok exact-change(5,5,10,10,20);

sub exact-change(*@a)
{
    my $bills = BagHash.new;

    while @a.shift -> $_
    {
        when 5  
        { 
            $bills<5>++ 
        }
        when 10 
        { 
            $bills<10>++;
            $bills<5>-- || return False
        }
        when 20
        {
            if $bills<10> and $bills<5> 
            {
                $bills<10>--;
                $bills<5>--
            }
            else
            {
                if $bills<5> >= 3 
                { 
                    $bills<5> -= 3 
                }
                else
                {
                    return False
                }
            } 
        }
    }

    True
}
