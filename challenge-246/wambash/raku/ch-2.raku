#!/usr/bin/env raku

sub linear-recurrence-of-second-order (+@a) {
    my $p = (@a[1]*@a[3] - @a[2]²)      div (@a[1]²-@a[0]*@a[2]);
    my $q = (@a[1]*@a[2] - @a[0]*@a[3]) div (@a[1]²-@a[0]*@a[2]);

    @a[0],@a[1], -> $x, $y { $p * $x + $q * $y  } ... *
    andthen .head(@a.elems) eqv @a.head(*)
    andthen  %(:$p, :$q) but $_
}

multi MAIN (Bool :test($)!) {
    use Test;
    is linear-recurrence-of-second-order(1, 1, 2,  3, 5)<p q>,(1,1);
    is linear-recurrence-of-second-order(1, 1, 2,  3, 5).so,True;
    is linear-recurrence-of-second-order(4, 2, 4,  5, 7)<p q>,(0,1);
    is linear-recurrence-of-second-order(4, 2, 4,  5, 7).so, False;
    is linear-recurrence-of-second-order(4, 1, 2, -3, 8)<p q>, (1,-2);
    is linear-recurrence-of-second-order(4, 1, 2, -3, 8).so, True;
    is linear-recurrence-of-second-order(5, 4, -2, 14)<p q>, (2,-3);
    is linear-recurrence-of-second-order(5, 4, -2, 14).so, True;
    done-testing;
}

multi MAIN (+a) {
    say so linear-recurrence-of-second-order a».Int
}
