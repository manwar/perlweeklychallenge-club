#!/usr/bin/perl6

#! Help
multi sub MAIN ( :help($h) where *.so ) { say $*USAGE; }

#| Reads a list of strings from STDIN 
#| Outputs them centered
multi sub MAIN () {
    .say for center( $*IN.lines );
}

sub center ( *@lines, :$len = max( @lines.map( *.codes ) ) ) {
    @lines.map( { "{ ' ' x ( ( $len - $_.codes ) div 2 )}$_" } );
}