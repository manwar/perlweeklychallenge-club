use v6;

sub MAIN(Int :$limit = 9) {
    # Use Slip() to flatten the list just one level
    my @exponents-list = (^$limit).produce(&grow)
        .map({ Slip( $_ ?? $_ !! () ) });
    # 3D coordinates used as powers of the allowable
    # prime factors
    for @exponents-list {
        # @() is used to indicate multiple element in the
        # argument list to the Z operator (also below)
        say [*] (2, 3, 5) Z** @($_)
    }
}

multi sub grow (Int, Int) { ((0, 0, 0),) }
multi sub grow (List $a, Int $b --> List()) {
    # Sequence of integral points in 3D space where sum
    # of coordinates is the next integer (0, 1, 2 ...)
    ( @($a) XZ+ (1, 0, 0), (0, 1, 0), (0, 0, 1) )
        .map(*.List).unique(:with(&[eqv]));
}
