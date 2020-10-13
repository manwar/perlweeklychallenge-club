unit sub MAIN( Str $A, Str $B, Str $C where $C.chars == $A.chars + $B.chars );

sub interleavable( Str $a, Str $b, Str $c ) {
    so grep { $c eq [~] $a.substr( 0, $^i ), $b, $a.substr( $^i ) }, ^$a.chars }

say +( interleavable( $A, $B, $C ) || interleavable( $B, $A, $C ) )