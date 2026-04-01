#!raku

#
# Perl Weekly Challenge 367
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-367>
#

sub MAIN( *@times where { @times.elems == 4 && @times.grep( * ~~ / ^ \d ** 2 ':' \d ** 2 $ / ).elems == 4 } ) {
    my @first;
    my @second;

    for 0 .. 1 {
	@first.push: @times[ $_ ].split( ':' ).map( *.Int )[ 0 ] * 60
				       + @times[ $_ ].split( ':' ).map( *.Int )[ 1 ];
    }

    for 2 .. 3 {
	@second.push: @times[ $_ ].split( ':' ).map( *.Int )[ 0 ] * 60
		       + @times[ $_ ].split( ':' ).map( *.Int )[ 1 ];
    }

    'True'.say and exit if ( @second[ 0 ] - @first[ 1 ] < 0 || @second[ 1 ] - @first[ 0 ] < 0 );
    'False'.say;
}
