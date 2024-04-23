#!/usr/bin/env raku
use Test;

is-deeply uncommon-words('Mango is sweet', 'Mango is sour'),    ('sweet', 'sour'), 'example 1';
is-deeply uncommon-words('Mango Mango',    'Orange'),           ('Orange',),       'example 2';
is-deeply uncommon-words('Mango is Mango', 'Orange is Orange'), (),                'example 3';

sub uncommon-words($s1, $s2)
{
    # A literal translation using the one and none junctions
    sub uw($s1, $s2)
    {
        my @s1 = $s1.words;
        my @ones = @s1.unique.grep(one @s1);
        @ones.grep(none $s2.words) 
    }
    
    flat uw($s1, $s2), uw($s2, $s1)
}
