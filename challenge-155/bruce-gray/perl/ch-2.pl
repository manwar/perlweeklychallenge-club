use Modern::Perl;
use experimental qw<signatures>;
use List::Lazy   qw<lazy_list>;
use List::Util   qw<all>;

# This algorithm assumes the cycle must start at position zero.
# Works with string or numberic elements, if the strings have no whitespace.
sub find_period ( $lazy_list ) {
    my @ns = ( $lazy_list->next(2) );
    return if not @ns;

    my $ns0 = $ns[0];
    my @L = $ns[0];
    my @R = $ns[1];
    my $cycle_length = 1;
    while (1) {
        # Easy check - if element is different from $ns0, the cycle cannot start there.
        if ( $R[0] eq $ns0 ) { 
            # If the first N values the same
            # as the _next_ N values, we will call it a cycle.
            return $cycle_length if all { $L[$_] eq $R[$_] } keys @L;
        }

        push @L, shift @R;
        push @R, $lazy_list->next(2);
        $cycle_length++;

        return if $lazy_list->is_done;
    }
}

sub nth_Pisano_period ( $n ) {
    die      if $n <  1;
    return 1 if $n == 1;

    my $fib_mod = lazy_list { 
        push  @$_, ( $_->[0] + $_->[1] ) % $n;
        shift @$_;
    } [0, 1];

    return find_period($fib_mod);
}

die if join( ',', map { nth_Pisano_period($_) }  1 .. 20 )
    ne join( ',', (1,3,8,6,20,24,16,12,24,60,10,24,28,48,40,24,36,24,18,60) );

say nth_Pisano_period( shift // 3 );
