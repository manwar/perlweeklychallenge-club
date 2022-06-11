sub find_period ( @a ) {
    return Nil if not @a;
    return 1   if [==] @a.head(4);

    # If the first N values the same
    # as the _next_ N values, we will call it a cycle.
    sub is_a_cycle ( $cycle_length ) {
        @a.head($cycle_length) eqv @a.skip($cycle_length).head($cycle_length);
    }

    my $a0 = @a[0];

    # Since cycles must start with the @a[0] value,
    # the positions where that value re-occurs
    # are the only possible cycle lengths.
    return @a.grep( :k, * == $a0 ).skip.first: &is_a_cycle;
}
sub nth_Pisano_period ( UInt $n ) {
    return 1 if $n == 1;

    my @Fib = 0, 1, -> \a, \b { (a + b) % $n } ... Inf;

    return find_period(@Fib);
}

die unless [map &nth_Pisano_period, 1 .. 20]
       eqv [1,3,8,6,20,24,16,12,24,60,10,24,28,48,40,24,36,24,18,60];

say nth_Pisano_period +( @*ARGS[0] // 3 );
