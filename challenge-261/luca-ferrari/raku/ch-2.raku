#!raku

#
# Perl Weekly Challenge 261
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-261>
#

sub MAIN( Int $start is copy,
	  *@nums where { @nums.elems == @nums.grep( * ~~ Int ).elems } ) {

    while ( @nums.grep( * ~~ $start ) ) {
	$start *= 2;
    }

    $start.say;
}
