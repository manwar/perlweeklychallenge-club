# Use the first n pentagonal numbers. The zeroth element is not used so
# p_1, p_2, ..., p_n will correspond to $p[1], $p[2], ..., $p[n].
#
# The maximum pair of pentagonal numbers that can be tested are p_i and p_j
# where 3 <= i < n, 2 <= j < i, and p_i + p_j <= p_n.
my $n = 1_000_000;

# Use Raku's sequence operator to define an infinte lazy list containing
# the pentagonal numbers. See
#     https://perl6advent.wordpress.com/2010/12/04/the-sequence-operator
# for more information on the sequence operator. $p[0] (= 0) is not used.
my $p := 0, 1, 5, -> $a, $b { 2*$b - $a + 3 } ... Inf;

# Make a is-pentagonal hash where %is-pentagonal{p-1} is true for the first
# n pentagonal numbers.
my %is-pentagonal;
(1 .. $n).map({%is-pentagonal{$p[$_]} = True});

for (3 .. $n-1) -> $i {
    for (2 .. $i-1) -> $j {

        # Is p_i + p_j a pentagonal number?
        my $t = $p[$i] + $p[$j];
        ($t > $p[$n]) and die "sum $t is too big to test";
        %is-pentagonal{$t} or next;

        # Is p_i - p_j a pentagonal number?
        $t = $p[$i] - $p[$j];
        %is-pentagonal{$t} or next;

        # The following numbers get printed: 1560090 and 7042750.
        print qq:to/END/;
        The first pair of pentagonal numbers that satisfy
        the conditions is ($p[$j], $p[$i]).
        END
        exit 0;

    }
}
