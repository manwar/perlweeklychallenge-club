#!/usr/bin/env raku
use Test;

is travel-expenditure(1,5,6,7,9,15),                   11; 
is travel-expenditure(1,2,3,5,7,10,11,12,14,20,30,31), 20; 
is travel-expenditure(1..2500),                        2088; 
is travel-expenditure(1..2520),                        2100; 
is travel-expenditure(1..2525),                        2107; 
is travel-expenditure(1..2528),                        2109; 

# Not the most elegant solution but it's pretty fast.

sub travel-expenditure(+@days)
{
    my $cost;
    my %cost     := { 1 => 2, 7 => 7, 30 => 25 }
    my %min-span := { 1 => 1, 7 => 4, 30 => 23 }

    for (30,7,1) -> $n
    {
        loop
        {
            last unless @days;
            my %days = @days.antipairs;
            my @mm = @days.minmax.rotor($n => $n-1);

            unless @mm
            {
                delete-days(@days) if @days.minmax >= %min-span{$n};
                last
            }

            my @ints = do ($_ (&) @days).keys for @mm;

            my %c = @ints.classify({ .elems });

            last unless %c.max.key >= %min-span{$n};
        
            delete-days(%c.max.value.head);
    
            sub delete-days(@a)
            {
                %days{@a}:delete;
                @days = %days.keys>>.Int;
                $cost += %cost{$n};
            }
        }
    }

    $cost
}
