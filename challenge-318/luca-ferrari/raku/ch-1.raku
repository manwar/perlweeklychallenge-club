#!raku

#
# Perl Weekly Challenge 318
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-318>
#

sub MAIN( Str $string ) {
    $string.comb.unique.map( -> $char { ( $string ~~ / $char ** 3 / // '' ).Str } )
		          .grep( { $_.chars == 3 } )
		          .join( ', ' ).say;
}
