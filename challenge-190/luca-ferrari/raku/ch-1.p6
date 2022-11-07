#!raku

# Perl Weekly Challenge 190

sub MAIN( Str $word ) {

    '1'.say and exit if ( $word ~~ /
			  | ^ <[A .. Z]> <[a .. z]>+ $
			  |  ^ <[a..z]>+ $
			  | ^ <[A..Z]>+ $ / );
    '0'.say;
}
