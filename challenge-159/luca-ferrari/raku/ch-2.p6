#!raku
# Perl Weekly Challenge 159

sub prime-factors( Int $n ) {
    my $number = $n;
    my @factors;

    my $factor = 2;
    while ( $number > 1 && $factor <= $number ) {
        if ( $number %% $factor ) {
            @factors.push: $factor;
            $number /= $factor;
        }
        else {
            $factor++;
        }
    }

    return @factors;
}


sub MAIN( Int $n where { $n > 0 } ) {

    my @prime-factors = prime-factors( $n );
    '0'.say and exit if @prime-factors.elems != @prime-factors.unique.elems;
    '1'.say and exit if @prime-factors.unique.elems %% 2;
    '-1'.say and exit;

}
