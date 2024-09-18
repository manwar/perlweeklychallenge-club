sub valid-number ($in) {
    my token sign { <[+-]> }
    my regex integer { <sign>? \d+ }
    my token exponent { <[eE]> <integer> }
    my token decimal {
        <integer> '.'? | <sign>? '.'? \d+ | <integer> '.' \d+
    }
    my regex float { <decimal> <exponent> }
    my token number { <float> | (<decimal> <exponent>?) }

    return so $in ~~ /^ <number> $/ ;
}

for <1 a . 1.2e4.2 -1 +1E-8 .44 16 12.5 5e17e3 foo> -> $test {
    printf "%-10s => ", $test;
    say valid-number $test;
}
