#!raku

sub factors ( Int $number ) {
    return $number if $number == 1 || $number.is-prime;

    my @factors;
    my $value = $number;
    for ( 2 .. $value div 2 ).grep( *.is-prime ) -> $candidate {
        while $value %% $candidate {
            @factors.push: $candidate;
            $value /= $candidate;
        }
    }

    return @factors;
}


sub MAIN( Int $limit = 500 ) {
    my %solutions;
    for 1 .. $limit {
        my @factors = factors( $_ );

        my $ok = True;
        for @factors -> $current-factor {
            if @factors.grep( $current-factor ).elems > 1 {
                $ok = False;
                last;
            }
        }


        %solutions{ $_ } = @factors if $ok;
    }


    "$_ = { %solutions{$_}.join( ' x ' ); }".say for %solutions.keys.sort;
}
