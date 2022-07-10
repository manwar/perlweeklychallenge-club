sub prime-partitions ( UInt $m, UInt $n --> Seq ) {
    constant @primes = grep &is-prime, ^Inf;

    my @p = @primes.head: @primes.first( :k, * > $m );

    return @p.combinations($n).grep( *.sum == $m );
} 
# Note that the `or` in the task example output is ambiguous.
# I am returning all of the partitions. To only return one, change `grep` to `first.

# There are certainly more efficient partitioning algorithms w.r.t. runtime,
# but Raku's built-in .combinations was most efficient of *programmer* time.


multi sub MAIN ( UInt $m, UInt $n ) {
    say prime-partitions($m, $n);
}
multi sub MAIN ( ) {
    constant @tests = 
        ( (18, 2), ( (5, 13), (7, 11) ) ),
        ( (19, 3), ( (3, 5, 11),      ) ),
        ( (77, 8), ( (2, 3, 5, 7, 11, 13, 17, 19), ) ),
    ;
    use Test;
    plan +@tests;
    for @tests -> ( ($m, $n), $expected ) {
        my $got = prime-partitions($m, $n);
        is-deeply $got, $expected, "prime-partitions($m, $n)";
    }
}
