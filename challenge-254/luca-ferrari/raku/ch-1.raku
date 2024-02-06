#!raku

#
# Perl Weekly Challenge 254
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-254>
#

sub MAIN( Int $n ) {
    #    say ( $n ** ( 1 / 3 ) ).Int == ( $n ** ( 1 / 3 ) );
    for ( 2 ..^ $n.sqrt.Int ) {
	'true'.say and exit if ( $_ ** 3 == $n );
    }

    'false'.say;
}
