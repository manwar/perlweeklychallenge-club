unit sub MAIN( Str $A, Str $B, Str $C where $C.chars == $A.chars + $B.chars );

say +so grep { $C eq [~] $A.substr( 0, $^i ), $B, $A.substr( $^i ) }, ^$A.chars