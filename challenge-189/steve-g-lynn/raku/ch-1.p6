#!/usr/bin/env perl6

say &greater-character('b',qw/e m u g/); #e
say &greater-character('a',qw/d c e f/); #c
say &greater-character('o',qw/j a r/); #r
say &greater-character('a',qw/d c a f/); #c
say &greater-character('v',qw/t g a l/); #Inf [min of empty array]

sub greater-character( $target, @arry ) {    
    @arry.sort({$^a cmp $^b}).grep({$_ gt $target}).min;
}

