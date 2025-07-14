#!raku

#
# Perl Weekly Challenge 330
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-330>
#

sub MAIN( Str $string is copy
	  where { $string ~~ / ^ <[a .. z 0 .. 9 ]>+ $ / } ) {

    while ( $string ~~ / (<[a .. z]>) (<[ 0 .. 9 ]>) / ) {
	$string .= subst( / (<[a .. z]>) (<[ 0 .. 9 ]>) /, '' );
    }

    $string.say;
}
