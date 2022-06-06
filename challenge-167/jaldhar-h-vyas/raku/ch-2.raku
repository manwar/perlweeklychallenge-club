#!/usr/bin/raku

sub Γ(Real $n) {
    my $z = Complex.new($n, 0);

    if $z.re <  0.5 {
        return pi / sin(pi * $z) / Γ(1 - $z);
    } else {
        my @coefficients = <
            676.5203681218851
            -1259.1392167224028
            771.32342877765313
            -176.61502916214059
            12.507343278686905
            -0.13857109526572012
            9.9843695780195716e-6
            1.5056327351493116e-7
        >;
        $z -= 1;
        my $sum = 0.99999999999980993;
        my $i =  0;
        for @coefficients -> $c {
            $sum += $c / ($z + 1 + $i++);
        }
        my $t = $z + @coefficients.elems - 0.5;
        return dropImaginary(sqrt(2 * pi) * $t ** ($z + 0.5) * exp(-$t) * $sum);
    }
}

sub dropImaginary(Complex $n) {
    constant ε = 1e-7;
    my $z = $n;

    if $z.im.abs < ε {
        $z = $z.re;
    }

    return $z;
}

sub MAIN() {
    for (3, 5, 7) -> $i {
        say Γ($i).round(0.01); 
    }
}