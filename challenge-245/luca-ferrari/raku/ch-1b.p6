#!raku

#
# Perl Weekly Challenge 245
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-245/>
#

# $ raku raku/ch-1.p6  --langs="c" --langs="java" --langs="python" --popularity=2 --popularity=3 --popularity=5

sub MAIN( :@langs where { @langs.elems == @langs.grep( * ~~ Str ).elems }
	  , :@popularity where { @popularity.elems == @langs.elems == @popularity.grep( * ~~ Int ).elems } ) {

    ( @langs [Z] @popularity ).sort( { $^b[1] <=> $^a[1] } ).map( *[ 0 ] ).join( ',' ).say;
}
