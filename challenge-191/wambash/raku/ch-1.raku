#!/usr/bin/env raku

sub twice-largest (+@list) {
   so @list.max < @list.one * 2
}

multi MAIN (Bool :test($)!) {
    use Test;
    is twice-largest(1,2,3,4),False;
    is twice-largest(1,2,0,5),True;
    is twice-largest(2,6,3,1),True;
    is twice-largest(4,5,2,3),False;
    done-testing;
}

multi MAIN (*@list) {
    say twice-largest( @list ) ?? 1 !! -1
}
