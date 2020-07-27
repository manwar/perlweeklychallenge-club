sub MAIN ( Int $bits where {$bits > 1} = 8) {

    grey_code( $bits ).put;

}

sub grey_code ( $bits ) {
    return (0,1) when $bits == 1;

    return (0,1).map({
        my $n = $_;
        my @gc  = grey_code($bits-1).map: {$_.fmt('%0' ~ ($bits-1) ~ 'b')};
        ($_ ?? reverse @gc !! @gc).map:{ $n ~ $_ };
    }).flat.map:{ :2($_ )}
}
