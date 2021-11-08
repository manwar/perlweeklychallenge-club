#!raku


sub is-conflict( @interval-a, @interval-b ) {
    return False if ! @interval-a || ! @interval-b;
    return False if @interval-a ~~ @interval-b;
    return True if @interval-a[ 0 ] <= $_ <= @interval-a[ 1 ] for @interval-b;
    return False;
}


sub MAIN() {
    my @intervals = [ [1,4], [3,5], [6,8], [12, 13], [3,20] ];

    my %conflicts;

    
    for 0 ..^ @intervals.elems -> $i {
        %conflicts{ @intervals[ $i ] }++ if is-conflict( $_, @intervals[ $i ] ) for @intervals[ 0 .. $i - 1 ];
    }

    for %conflicts.kv -> $what, $how-much {
        "$what conflicts $how-much times".say;
    }
}

