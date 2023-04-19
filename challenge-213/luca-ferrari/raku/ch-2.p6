#!raku

#
# Perl Weekly Challenge 213
# Task 2
#
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-213/>
#
#
# raku raku/ch-2.p6 1 7 "1 2 3 |  4 5 6 | 3 8 9 |  7 8 "
# 1 -> 2 -> 3 -> 8 -> 7


sub MAIN( Int $source, Int $destination, $r ) {
    my @routes;
    my @current;
    for $r.comb( :skip-empty ) {
	next if ! $_;

	if $_ ~~ "|" {
	    @routes.push: [@current];
	    @current = ();
	    next;
	}

	@current.push: $_.Int if ( $_.Int > 0 );

    }

    @routes.push: [@current] if ( @current );

    my ( $source-index, $destination-index );
    for 0 ..^ @routes.elems -> $index {
	$source-index = $index and next if ( @routes[ $index ].grep( $source ) );
	$destination-index = $index and next if ( @routes[ $index ].grep( $destination ) );
    }


    my @current-path;
    my $next-route = $source-index;
    my $loop = True;
    while ( $loop ) {
	for @routes[ $next-route ].Array -> $node {
	    @current-path.push: $node if ( ! @current-path.grep( * ~~ $node ) );

	    $loop = False;
	    for $next-route ^..^ @routes.elems -> $jump-to {

		if ( @routes[ $jump-to ].grep( { $_ ~~ $node } ) ) {
		    $next-route = $jump-to;
		    $loop = True;
		    last;
		}
	    }

	    last if $loop;
	}
    }

    @current-path.join( ' -> ' ).say;
}
