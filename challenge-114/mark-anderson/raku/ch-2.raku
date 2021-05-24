#!/usr/bin/env raku

# my translation of http://www.slideshare.net/gkumar007/bits-next-presentation
# (slide 9)

use Test;
plan 9;

is next-set-bits(3),     5;
is next-set-bits(6),     9;
is next-set-bits(11),   13;
is next-set-bits(23),   27;
is next-set-bits(24),   33;
is next-set-bits(44),   49;
is next-set-bits(46),   51;
is next-set-bits(240), 263;
is next-set-bits(2³²), 2³³;

sub next-set-bits($N)
{
    my $bits = 0 ~ $N.base(2);

    my $m = $bits ~~ / $<head> = <[01]>* 0 $<ones> = 1+ $<zeros> = 0* /;
   
    my @ones  = $m<ones>.comb andthen .shift;
    my @bits  = @ones andthen .append($m<zeros>.comb);
       @bits .= rotate(@ones);    

    $m<head> ~ 10 ~ @bits.join andthen .parse-base(2);
}
