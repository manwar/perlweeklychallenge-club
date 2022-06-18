#!/usr/bin/env raku

# Implement subroutine gamma() using the Lanczos approximation method.
# https://en.wikipedia.org/wiki/Lanczos_approximation
# https://ry.ca/2022/05/lanczos-approximation

sub MAIN(Int $z) {
    say gamma($z).round(0.01); 
}

sub gamma(Real $n) {
    my $z = Complex.new($n, 0);
    return pi / (sin($z * pi) * gamma(1 - $z)) if $z < 0.5;

    my @p   = <
          676.520368121885098567009190444019
        -1259.13921672240287047156078755283
          771.3234287776530788486528258894
         -176.61502916214059906584551354
           12.507343278686904814458936853
           -0.13857109526572011689554707
            9.984369578019570859563e-6
            1.50563273514931155834e-7
    >; 
    
    $z -= 1;
    my $x =   0.99999999999980993227684700473478;
    for 0 ..^ @p -> $i {
        $x += @p[$i] / ($z + $i + 1);   
    }
    my $t = $z + @p.elems - 0.5;
    
    return dropImag(
        sqrt(2 * pi) * $t ** ($z + 0.5) * exp(-$t) * $x
    );
}

sub dropImag(Complex $n) {
    my $z = $n;

    if $z.im.abs < 1e-7 {
        $z = $z.re;
    }

    return $z;
}

