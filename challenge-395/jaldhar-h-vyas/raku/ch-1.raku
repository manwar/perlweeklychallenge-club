#!/usr/bin/raku

sub normalize(Str $num) {
    $num.match(/
        $<real> = ['-'? \d+]
        \+
        [\(? $<imaginary> = ['-'? \d+] \)?]
        i
    /);
    return ($<real>,$<imaginary> < 0 ?? '-' !! '+', $<imaginary>.abs,'i').join;
}

sub denormalize(Complex $num) {
    return $num.im < 0 ?? ($num.re, "+(", $num.im, ")i").join !! $num;
}

sub MAIN(
    Str $num1, #= a complex number
    Str $num2  #= a complex number
) {
    say denormalize(normalize($num1) * normalize($num2));
}
