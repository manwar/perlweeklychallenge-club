#!/usr/bin/env raku

#| Generate the first 20 Pallandromic Prime Cyclops numbers
sub MAIN() {
    .say for (1..*).hyper.grep( *.is-prime ).grep( { $_ ~~ /^ $<start>=(<[1..9]>+) '0' {} $($<start>.flip) $/ })[^20];
}
