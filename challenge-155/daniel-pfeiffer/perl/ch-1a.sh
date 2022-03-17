pl -Mbignum -OA2..30 '@a = 0; @b = $a = $b = 1;
    while( 1 ) {
        if( @a < @b || $a[0] != $b[0] ) {
            push @a, shift @b
        } elsif( "@a" eq "@b ) {
            last;
        }
        push @b, $b % $ARGV;
        ($a, $b) = ($b, $a + $b)
    }
    say "$ARGV: @a"'
