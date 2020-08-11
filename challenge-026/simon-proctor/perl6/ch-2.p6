#!/usr/bin/env perl6

use v6;

my %*SUB-MAIN-OPTS = :named-anywhere;

#| Document script
multi sub MAIN( Bool :h(:$help) where ?* ) { say $*USAGE }

#| Take a list of angles in Radians and return the Mean of them in Radians
multi sub MAIN(
    *@rad-angles where *.elems > 1 #= List of at least 2 angles in Radians
) {
    say find-mean( @rad-angles );
}


#| Take a list of angles in Degress and return the Mean of them in Degrees
multi sub MAIN (
    Bool :deg(:$degrees) where ?*, #= Degrees flag
    *@deg-angles where *.elems > 1 #= List of at least 2 angles in Degrees
) {
    my @rad-angles = @deg-angles.map( * * π / 180 );
    
    say ( find-mean(@rad-angles) * (180 / π) ).round(0.01);
}

sub find-mean( @angles is copy ) {
    my $sin = (1/@angles.elems) * ( [+] @angles.map( { sin($_) } ) );
    my $cos = (1/@angles.elems) * ( [+] @angles.map( { cos($_) } ) );
    
    $sin.atan2( $cos );
}
