#!raku

#
# Perl Weekly Challenge 280
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-280>
#

sub MAIN( Str $string where { $string ~~ / ^ <[a..z]>+ $ / } ) {
    for $string.comb -> $needle {
	$needle.say and exit if ( $string.comb.grep( * ~~ $needle ).elems > 1 );
    }
}
