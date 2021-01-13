# Flip Binary
#
# You are given a binary number B, consisting of N binary digits 0 or 1: s0,
# s1, …, s(N-1).
#
# Choose two indices L and R such that 0 ≤ L ≤ R < N and flip the digits s(L),
# s(L+1), …, s(R). By flipping, we mean change 0 to 1 and vice-versa.
#
# For example, given the binary number 010, the possible flip pair results are
# listed below:
#
#     L=0, R=0 the result binary: 110
#     L=0, R=1 the result binary: 100
#     L=0, R=2 the result binary: 101
#     L=1, R=1 the result binary: 000
#     L=1, R=2 the result binary: 001
#     L=2, R=2 the result binary: 011
#
# Write a script to find the indices (L,R) that results in a binary number with
# maximum number of 1s. If you find more than one maximal pair L,R then print
# all of them.
#
# Continuing our example, note that we had three pairs (L=0, R=0), (L=0, R=2),
# and (L=2, R=2) that resulted in a binary number with two 1s, which was the
# maximum. So we would print all three pairs.


sub binflip($n is copy, $size, $L, $R) {
    for $L..$R -> $i {
        $n = $n +^ 2**($size - $i - 1);
    }
    return $n;
}

sub count-ones($n) {
    $n.base(2).Str.comb().grep({ $_ == '1'; }).elems;
}

sub task($bin, $N) {
    my @results = [];
    for 0..^$N X 0..^$N -> ($L, $R) {
        if ($L <= $R) {
            my $flip = binflip($bin, $N, $L, $R);
            my $count1 = count-ones($flip);
            @results.push(($count1, $L, $R, $flip));
        }
    }
    @results = @results.sort.reverse;
    my $max-ones = @results[0][0];
    return [-> ($c1, $L, $R, $f) {
        ($L, $R, $f) if $c1 == $max-ones } for @results];
}


my $bin = 0b010;
my $N = 2;  # Number of binary digits to extend to.
for task($bin, $N) -> ($L, $R, $f) {
    say "(L=$L, R=$R) binary: ", $f.base(2);
}
