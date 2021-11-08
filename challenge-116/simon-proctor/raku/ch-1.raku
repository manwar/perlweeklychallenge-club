#!/usr/bin/env raku

#| Given a number return the list of incrementing values if they exist.
multi sub MAIN (
    UInt $N where * >= 10 #= Number to test (at least 2 digits)
) {
    find-list($N).join(",").say;
}

multi sub MAIN ("test") is hidden-from-USAGE {
    use Test;
    is find-list( 1234 ), [1,2,3,4];
    is find-list( 91011 ), [9,10,11];
    is find-list( 10203 ), [10203];
    is find-list( 123124125), [123,124,125];
    done-testing;
}

sub find-list( UInt \N ) {
    for (1..N.codes) -> $split {
	my $start = N.substr(0,$split);
	my $rest = N.substr($split);
	my $result = check-list( [$start], $rest );
	if ( $result ) {
	    return $result;
	}
    }
}

multi sub check-list( @list, "" ) {
    return @list
}

multi sub check-list( @list, $rest ) {
    my $next = @list[*-1]+1;
    if ( $rest.substr(0,$next.codes) == $next ) {
	return check-list( [ |@list, $next ], $rest.substr($next.codes) );
    } else {
	return False;
    }
}
