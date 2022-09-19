sub is-permuted-multiple ( UInt $n --> Bool ) {
    return [eqv] map *.comb.Bag, ( $n X* 1..6 );
}

sub first-permuted-multiple-of-size ( UInt $size --> UInt ) {
    # For N digit numbers, no need to check beyond (10**N)/6,
    # because the 6x multiplication will overflow the digit count.
    # Example, when size=5, 16666*6=99996 (same # of digits),
    # but 16667*6=100002 (mis-matched # of digits; impossible to qualify).
    # So, this technique removes 5/6 of the search space.
    #
    # See blog post for more possible optimization.
    #
    my $min = 10 ** $size;
    my $max = ( $min * 10 / 6 ).floor;
    return first &is-permuted-multiple, $min..$max;
}

say first &is-permuted-multiple, 1..Inf; # Simplest approach

# say first *.so, map &first-permuted-multiple-of-size, ^Inf; # Faster
