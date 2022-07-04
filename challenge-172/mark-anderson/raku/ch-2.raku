#!/usr/bin/env raku
use Test;

is five-number-summary(1, 2, 3, 4, 5, 6),    
   {:lower-q(2), :median(3.5), :min(1), :upper-q(5)};
is five-number-summary(1, 2, 3, 4, 5, 6, 7), 
   {:lower-q(2), :median(4), :min(1), :upper-q(6)}
is five-number-summary(6, 7, 15, 36, 39, 40, 41, 42, 43, 47, 49),
   {:lower-q(15), :median(40), :min(6), :upper-q(43)}
is five-number-summary(7, 15, 36, 39, 40, 41),
   {:lower-q(15), :median(37.5), :min(7), :upper-q(40)}

sub five-number-summary(+@a)
{
    @a .= sort;

    return {
               min     => @a.head,
               median  => median(@a),
               lower-q => quartile('lower'),
               upper-q => quartile('upper')
           }

    sub median(@a) 
    {
        my $r = @a.elems div 2;
        @a.elems mod 2 ?? @a[$r] !! (.head.tail + .tail.head) / 2 
        given @a.rotor($r).cache
    }

    sub quartile($s)
    {
        # method 1 from https://en.wikipedia.org/wiki/Quartile
        my $r = @a.elems div 2;
        my @t = @a.elems mod 2 ?? @a.rotor($r, 1, $r) !! @a.rotor($r);
        $s eq 'lower' ?? median(@t.head) !! median(@t.tail);
    }
}
