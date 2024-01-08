use Test;

sub shortest-distance(Str $s, Str $char) {
    my @positions = $s.comb.indices($char);
    return $s.chars.map({ my $i = $_; @positions.map({ abs($i - $_) }).min });
}

# Tests
is-deeply shortest-distance("loveleetcode", "e"), [3, 2, 1, 0, 1, 0, 0, 1, 2, 2, 1, 0];
is-deeply shortest-distance("aaab", "b"), [3, 2, 1, 0];

done-testing;
