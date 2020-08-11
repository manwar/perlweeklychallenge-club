#!/usr/bin/perl6
use v6;

# 20.1 Write a script to calculate the value of e, also known as Euler’s number and Napier’s constant.

# Let's do 5 different ways for fun!

sub e_sum_infinte_series($i) {
    my $e=1;
    for ^$i { state $j=1; state $n=1;
        $j*=1/$n;
        $n++;
        $e+=$j;
    }
    return $e;
}

sub e_sum_infinite_series_limit($n) {
    return (1 + 1/$n) ** $n
};

sub e_continued_fraction($n) {
    # calculated in reverse order to avoid recursion
    my $frac=1;
    my @seq=lazy gather for 1..Inf  -> $a  {take 1; take 2*$a; take 1} ;
    for (0..^$n).reverse -> $i {
        $frac=1/(@seq[$i]+$frac);
    }
    return $frac+2;
};

sub e_continued_fraction_faster($n) {
    # calculated in reverse order to avoid recursion
    my $frac=1;
    # we skip a step in sequence here as we add it at end...
    my @seq=6,-> $a { $a+4 } ... * ;
    for (0..^$n-1).reverse -> $i {
        $frac=1/(@seq[$i]+$frac);
    }
    # Final (i.e.) first iteration here as it differnt...
    return 1+2/(1+$frac);
};

sub V() {
     my $n=0;
     my $sumX=0;
     loop {
        $sumX+=1.rand;
        $n++;
        return $n if $sumX>1;
     }
};

sub E($n) {
    return ([+] (V() for ^$n) ) /$n
};

# calculate e with 10 iterations of infinite series - sum (1/n!)
say e_sum_infinte_series(10);

say e_sum_infinite_series_limit(10_000);

say e_continued_fraction(10);

# best results with this one
say e_continued_fraction_faster(10);

# Stochaistic derivation of e;
say E(100_000);
