#!raku

# Perl Weekly Challenge 168

sub prime-factors( Int $n where { $n > 0 } )
{
    my $number = $n;
    my @factors;
    return $n if $n.is-prime;

    for 2 ..^ $n {
        next if ! $_.is-prime;
        next if $number !%% $_;
        next if $_ > $number;

        while ( $number %% $_ ) {
            @factors.push: $_;
            $number /= $_;
        }

    }

    return @factors;
}

sub HP( Int $n where { $n > 0 } )
{
    my $number = prime-factors( $n ).join.Int;
    return $number if $number.is-prime;
    return HP( $number );
}

sub MAIN( Int $n where { $n > 1 } = 10 ) {
    say HP( $n );
}
