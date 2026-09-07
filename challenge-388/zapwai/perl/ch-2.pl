use v5.38;

sub fact($n) {
    return 1 if ($n == 1);
    return $n*fact($n-1);
}

sub comb($n, $r) {
    return fact($n) / (fact($n-$r) * fact($r));
}

# Number of "Bad" (non secret-santa) maps
sub B($n, $k) {
    return comb($n, $k) * N($n-$k);
}

sub N($n) {
    return 0 if ($n == 1);
    my $bad = 1; # (one map fixes ALL values)
    # Sum over all the ways to have *exactly* one fixed value, or two, or three, etc.
    $bad += B($n, $_) for (1 .. $n-2);
    return fact($n) - $bad;
}

# N(n) = # of "secret santa" arrangements of n items (no fixed)
# N(1) = 0
# N(2) = 1
# N(3) = 3! - (3C1)*N(2) - 1
# N(4) = 4! - (4C1)*N(3) - (4C2)*N(2) - 1
# N(5) = 5! - (5C1)*N(4) - (5C2)*N(3) - (5C3)*N(2) - 1
#                          Bad maps -> B(k)
#     How many maps fix exactly ONE -> (nC1) * N(n-1) = B(1)
#     How many maps fix exactly TWO -> (nC2) * N(n-2) = B(2)
#   How many maps fix exactly THREE -> (nC3) * N(n-3) = B(3)

# N(n) = n! - [Sum_k=1^(n-2) B(k) + 1]
    
sub proc($n) {
    say "Input: $n";
    say "Output: ", N($n);
}

my $n = 1;
proc($n);
$n = 2;
proc($n);
$n = 3;
proc($n);
$n = 4;
proc($n);
$n = 6;
proc($n);
