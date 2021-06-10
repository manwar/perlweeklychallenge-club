#!/usr/bin/env raku


subset Even of Any where { $_ %% 2 };
subset Odd of Any where { $_ !%% 2 };

multi sub fusc($ where * == 0) { 0 }
multi sub fusc($ where * == 1) { 1 }
multi sub fusc(Even \n) { fusc( n / 2 ) }
multi sub fusc(Odd \n) { fusc( (n-1)/2 ) + fusc( (n+1)/2 ) }

#| Generate the first n FUSC numbers
sub MAIN( UInt \n ) {
    (0..^n).map( { fusc($_) } ).join(", ").say;
}
