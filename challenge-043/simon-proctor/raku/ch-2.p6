#!/usr/bin/enb perl6

use v6;

#| Calculate the self desscriptive number for the given base
sub MAIN( UInt \base where 1 <= * <= 36 ) {
    say calculate( base );
}

# No number available for these bases
multi calculate( \base where * ~~ 1|2|3|6 ) {
    "No self descriptive number for base {base}";
}

multi calculate(4) { "Either 1210 or 2020" }
multi calculate(5) { "21200" }

multi calculate(\base) {
    ((base-4)*(base**(base-1))+(2*(base**(base-2)))+(base**(base-3))+(base**3)).base(base);
}
