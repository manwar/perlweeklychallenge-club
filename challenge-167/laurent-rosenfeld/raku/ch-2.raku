use v6;

my @p = <676.5203681218851  -1259.1392167224028
    771.32342877765313      -176.61502916214059
    12.507343278686905      -0.13857109526572012
    9.9843695780195716e-6   1.5056327351493116e-7>;

my constant EPSILON = 1e-07;

sub drop-imaginary(Complex $z) {
    return $z.im.abs < EPSILON ?? $z.re !! $z;
}

sub gamma($z is copy) {
    my $y;
    if $z.re < 0.5 {
        $y = pi / (sin(pi * $z) * gamma(1 - $z));   # reflection formula
    } else {
        $z -= 1;
        my $x = 0.99999999999980993;
        for @p.kv -> $i, $pval {
            $x += $pval / ($z + $i +1);
        }
        my $t = $z + @p.elems - 0.5;
        $y = sqrt(2 * pi) * $t ** ($z + 0.5) * (-$t).exp * $x;
    }
    return drop-imaginary $y;
}

for 1, 3, 5, 6.2, 7, 0.4 -> $i {
    printf "$i -> %.5f\n", gamma $i.Complex;
}
