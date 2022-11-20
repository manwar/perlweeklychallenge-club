#!/usr/bin/env raku

subset ValidRange of Int where 0 < * <= 15;
subset LargeRange of Int where 9 < * <= 15;

#|( Given an int between 1 and 15 return the number of cute lists can be 
 made from the range 1..$n ) 
multi sub MAIN( ValidRange() $n ) {
    say cute-count( $n );
}

#|( Prints the list of cute counts for all values between 1 and 15)
multi sub MAIN() {
    my @checks;
    for (1..15) {
        my $a = $_;
        @checks.push( start { "$a : {cute-count($_)}" } );
    }
    await @checks;
    say $_.result for @checks;
}

multi sub MAIN( "TEST" ) is hidden-from-USAGE {
    use Test;
    is cute-count(2), 2;
    is cute-count(3), 3;
    is cute-count(4), 8;
    is cute-count(5), 10;
    is cute-count(10), 700;
    done-testing;
}

multi sub cute-count( ValidRange $n ) {
    my @list = 1..$n;
    if ( $n >= 10 ) {
        return [+] ( ^@list ).hyper.map( {
            possible-cute( 1, @list[$_], (|@list[0..$_-1], |@list[$_+1..*]) );
        });
    } else {
        return [+] ( ^@list ).map( {
            possible-cute( 1, @list[$_], (|@list[0..$_-1], |@list[$_+1..*]) );
        });
    }
}

multi sub possible-cute( $idx is copy, $val is copy, @rest ) {
    return 0 unless $idx %% $val || $val %% $idx;
    my $next = $idx+1;
    if ( @rest.elems > 10 ) {
        return [+] ( ^(@rest.elems) ).hyper.map( {
          possible-cute( $next, @rest[$_], (|@rest[0..$_-1], |@rest[$_+1..*]) )
        });
    } elsif ( @rest.elems ) {
        return [+] ( ^(@rest.elems) ).map( {
          possible-cute( $next, @rest[$_], (|@rest[0..$_-1], |@rest[$_+1..*]) )
        });
    }
    return 1;
}



