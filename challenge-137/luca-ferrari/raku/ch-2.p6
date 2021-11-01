#!raku

sub MAIN( Int $n where { 10 <= $n <= 10000 }, Bool :$verbose = False )  {

    my ( $result, $iteration ) = $n,0;
    while ( $result < 10_000_000 && $iteration < 500 ) {
        $iteration++;
        $result += $result.split( '' ).reverse.join;
        if $result == $result.split( '' ).reverse.join {
            '0'.say;
            "Found $result after $iteration iterations".say if $verbose;
            exit;
        }
    }

    '1'.say;
    "Cannot find Lychrel number for $n".say if $verbose;
}
