#!/usr/bin/env raku


my %*SUB-MAIN-OPTS = :named-anywhere, :bundling;

#| Brute force find the steps
multi sub MAIN( $a, :brute(:$b) where ?* ) {
    .join(" + ").say for (|(1 xx $a) ,|(2 xx $a)).combinations().unique( as => *.join(",")).grep( -> @a { ([+] @a) == $a } ).map( -> @a { | @a.permutations().unique( as => *.join(",") )  } );
}

#| Use Recursion to find the options
multi sub MAIN( $a, :recurse(:$r) where ?* ) {
    .say for find-steps( $a, [] );
}

multi sub MAIN( $a ) {
    MAIN( $a, :r );
}

multi sub find-steps( 0, @l ) {
    return @l.join( " + " );
}

multi sub find-steps( 1, @l ) {
    return [ |@l, 1 ].join( " + " );
}

multi sub find-steps( $v , @l ) {
    return [ |find-steps( $v-1, [ |@l, 1 ] ),
	     |find-steps( $v-2, [ |@l, 2 ] ) ];
}
