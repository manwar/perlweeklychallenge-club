#!/usr/bin/env raku
use v6.e.PREVIEW;
use Test;

is-deeply duplicate-zeros(1,0,2,3,0,4,5,0), (1,0,0,2,3,0,0,4);
is-deeply duplicate-zeros(1,2,3),           (1,2,3);
is-deeply duplicate-zeros(1,2,3,0),         (1,2,3,0);
is-deeply duplicate-zeros(0,0,1,2),         (0,0,0,0);
is-deeply duplicate-zeros(1,2,0,3,4),       (1,2,0,0,3);

sub duplicate-zeros(+@ints)
{
    my $s := flat @ints.head ?? (*.so,  *.not) xx * 
                             !! (*.not, *.so ) xx *;   

    my $i :=      @ints.head ?? (1,3...*)
                             !! (0,2...*);

    my @snips   = @ints.snip($s);
    @snips[$i] .= map({ $_ xx 2 });
    @snips.flat(:hammer).head(@ints)
}
