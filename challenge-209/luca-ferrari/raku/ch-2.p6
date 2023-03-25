#!raku

#
# Perl Weekly Challenge 209
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-209/>
#

sub MAIN() {

    my  @accounts =
	( "A", "a1@a.com", "a2@a.com" ),
        ( "B", "b1@b.com" ),
        ( "A", "a3@a.com", "a1@a.com" );

    my @merge;

    for 0 ..^ @accounts.elems {
	next if ! @accounts[ $_ ];
	my @current-emails = @accounts[ $_ ][ 1 .. * ];
	for $_ ^..^ @accounts.elems {
	    next if ! @accounts[ $_ ];
	    my @emails = @accounts[ $_ ][ 1 .. * ];
	    my @match  = @current-emails.grep( $_ )  for @emails;
	    if ( @match ) {
		@merge.push: [ @accounts[ $_ ][ 0 ], unique( sort(  |@emails, |@current-emails ) ) ];
		@accounts[ $_ ] = Nil;
		last;
	    }
	    else {
		@merge.push: [ @accounts[ $_ ] ];
	    }
	}
    }

    @merge.join( "\n" ).say;
}
