#!/usr/bin/env perl6
#
#
#       .raku
#
#
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ( $n = 60 ) ;

my $sq = $n**2;
my @triples;
my @summands;




for (1..$n) -> $t { 


    ## first we check table columns for summands 
    my $idx = 0;
    my $start = $t ** 2 + 2 * $t;           
    if ($sq - $start) % (2 * $t) == 0  {
        $idx = $t + 1 + ($sq - $start) / (2 * $t) ; 
        my @triple = sort $idx, $n, $idx - $t;
        push @triples, @triple if $idx > $t; 
    }
    ## then we check sum row for summands
    last if $t == $n;                           ## last column is at $n-1
    my $test = 2 * $t * $n - $t ** 2;           ## triangle equation

    if $test.sqrt ~~ /^\d+$/   {                ## perfect square test
        push @summands, $test.sqrt;
    }
}


push @triples,  (@summands.shift, @summands.pop, $n) while @summands.elems;

say sprintf "%4d² + %4d² = %d²", |$_ for @triples;

