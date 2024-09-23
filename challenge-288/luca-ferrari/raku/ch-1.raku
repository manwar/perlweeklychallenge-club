#!raku

#
# Perl Weekly Challenge 288
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-288>
#

sub MAIN( $number ) {

    # handling of special case:
    # one digit only
    if ( $number < 10 && $number >= 1 ) {
	say $number - 1;
	exit;
    }

    my ( $left, $right ) = $number - 1, $number + 1;
    while ( $right.Str.flip.Int != $right ) {
	$right++;
    }

    while ( $left.Str.flip.Int != $left ) {
	$left--;
    }

    # what is the one with the lowest difference?
    say $right - $number < $number - $left ?? $right !! $left;
}
