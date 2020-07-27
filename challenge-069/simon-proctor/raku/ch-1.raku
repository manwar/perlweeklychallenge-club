#!/usr/bin/env raku

#| Calculate the Strobogrammatic Numbers between $A and $B
sub MAIN (
    UInt $A, #= Start point
    UInt $B where { $A <= $B <= 10**15 } , #= End point
) {
    for (1..15) -> $length {
        for strobogrammatic($length) -> $s {
            next if $s < $A;
            exit if $s > $B;
            say $s;
        }
    }
}

multi sub rev( 6 ) { 9 }
multi sub rev( 8 ) { 8 }
multi sub rev( 9 ) { 6 }

multi sub strobogrammatic( 1 ) { ("8",) }

multi sub strobogrammatic( $length where { 1 < $length <= 3 } ) {
    my @base = [(6,),(8,),(9,)];
    make-strob( @base, $length );
}

multi sub strobogrammatic( $length ) {
    my @base = [X] ((6,8,9) xx ($length div 2));
    make-strob(@base,$length);
}

sub make-strob(@base,$length) {   
    @base.map( -> @start { |@start, |( $length %% 2 ?? () !! (8,) ), |@start.reverse.map( { rev($_) } ) } ).map( *.join("") );
}
