#!/usr/bin/env raku

# A translation of the Python code at https://en.wikipedia.org/wiki/Lanczos_approximation

use Test;

is-approx Γ(3), 2;
is-approx Γ(5), 24;
is-approx Γ(7), 720;

sub Γ($z is copy)
{
    my \ϵ = 1e-7;

    my @p = [ 676.5203681218851, 
             -1259.1392167224028,  
              771.32342877765313,
             -176.61502916214059, 
              12.507343278686905, 
             -0.13857109526572012,
              9.9843695780195716e-6, 
              1.5056327351493116e-7 ];

    my $y;

    $z .= Complex;

    if $z.re < ½
    {
        $y = π / (sin(π * $z) * Γ(1 - $z))  
    }

    else
    {
        $z--;
        my $x = 0.99999999999980993;
        $x += $_ / ($z + $++ + 1) for @p;
        my $t = $z + @p - ½;
        $y = sqrt(2 * π) * $t ** ($z + ½) * exp(-$t) * $x;
    }
    
    $y = $y.re if abs($y.im) <= ϵ;

    return $y;
}
