pl -Mbignum -OA2..30 '@a = 0; @b = $a = $b = 1;
    while( @a != @b || $a[0] != $b[0] || "@a" ne "@b" ) {
        push @a, shift @b if @a < @b || $a[0] != $b[0];
        push @b, $b % $ARGV;
        ($a, $b) = ($b, $a + $b)
    }
    say "$ARGV: @a"'
