#!/usr/bin/env raku
use Test;

is-deeply widest-valley(1, 5, 5, 2, 8), 
                       (5, 5, 2, 8),                  'Example 1';
is-deeply widest-valley(2, 6, 8, 5),    
                       (2, 6, 8),                     'Example 2';
is-deeply widest-valley(9, 8, 13, 13, 2, 2, 15, 17),  
                       (13, 13, 2, 2, 15, 17),        'Example 3';
is-deeply widest-valley(1, 3, 3, 2, 1, 2, 3, 3, 2), 
                       (3, 3, 2, 1, 2, 3, 3),         'Example 4';
is-deeply widest-valley(2, 1, 2, 1, 3), 
                       (2, 1, 2),                     'Example 5';

say widest-valley((10..50).roll(100_000)); # takes ~ 3 seconds

# This is ugly but I was determined to use a regular expression 🙄  
sub widest-valley(*@n)
{
    my %h = -1 => 'D', 0 => 'F', 1 => 'U'; 
    my $s = @n.rotor(2 => -1).map({ %h{(.[1] - .[0]).sign } }).join;
    my $h = 0;

    my $r := gather for $s ~~ m:g/ U (F*) D / -> $m
    {
        take ($h, $m.to.pred);
        $h = $m.to.pred - ($m[0] // '').chars;
        LAST { take ($h, $s.chars) }
    }

    my $m := $r>>.minmax;
    my $k  = $m>>.elems>>.flat.maxpairs.first.key;
    @n[ $m[$k] ]
}
