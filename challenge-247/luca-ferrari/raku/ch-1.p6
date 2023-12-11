#!raku

#
# Perl Weekly Challenge 247
# Task 1
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-247/>
#

sub MAIN( *@names where { @names.grep( * ~~ / ^ M (r||rs||iss) \. .* $ / ).elems == @names.elems } ) {

    my @santa = @names;
    my @receiving = @names;
    my @pairs;


    while ( @pairs.elems < @names.elems ) {
	for @santa.pick -> $santa {
	    next if @pairs.grep( { $_[ 0 ] ~~ $santa } );
	    for @receiving.pick -> $giving {
		next if $santa ~~ $giving;
		next if @pairs.grep( { $_[ 1 ] ~~ $giving } );
		@pairs.push: [ $santa, $giving ];
	    }
	}
    }

    "%s -> %s\n".printf( $_[ 0 ], $_[ 1 ] ) for @pairs;
}
