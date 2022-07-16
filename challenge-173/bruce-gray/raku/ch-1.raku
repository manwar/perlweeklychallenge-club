sub is-esthetic ( UInt $n --> Bool ) {
    so $n.comb.rotor(2 => -1).map({ abs [-] .list }).all == 1;
}

# Bonus: Efficent method to generate all esthetic numbers,
# without grepping through ℕ .
constant @all-esthetics = gather loop {
    state @last_generation = 1..9;
    .take for @last_generation;
    my @next_generation = gather for @last_generation -> $i {
        my $d = $i % 10;
        my $n = $i * 10 + $d;

        take $n - 1 if $d !== 0;
        take $n + 1 if $d !== 9;
    }
    @last_generation = @next_generation;
};


multi sub MAIN ( UInt $n ) {
    say is-esthetic $n;
}
multi sub MAIN ( 'test' ) {
    constant @A033075 = 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 21, 23, 32, 34, 43, 45, 54, 56, 65, 67, 76, 78, 87, 89, 98, 101, 121, 123, 210, 212, 232, 234, 321, 323, 343, 345, 432, 434, 454, 456, 543, 545, 565, 567, 654, 656, 676, 678, 765, 767, 787, 789, 876;
    constant @A090994 = 9, 17, 32, 61, 116, 222, 424, 813, 1556, 2986, 5721, 10982;

    use Test;
    plan 2;

    is (1..Inf).grep(&is-esthetic).head(54), @A033075,
        'https://oeis.org/A033075  Esthetic numbers';

    my $limit = @all-esthetics.first: :k, *.chars > @A090994.elems;
    is @all-esthetics.head($limit)».chars.Bag.sort».value, @A090994,
        'https://oeis.org/A090994  Number of n-digit terms in A033075';
}
