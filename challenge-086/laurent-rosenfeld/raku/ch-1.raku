use v6;

my @tests = [ 7, [10, 8, 12, 15, 5]],
            [ 6, [1, 5, 2, 9, 7]],
            [15, [10, 30, 20, 50, 40]],
            [9, [7, 20, 15, 11, 12]];
for @tests -> @R {
    my $found = False;
    my $target = @R[0];
    say "Testing: target: $target and @R[1]";
    for @R[1].combinations(2) -> $candidate {
        $found = True and say $candidate and last
            if abs($candidate[0] - $candidate[1]) == $target;
    }
    say +$found;
}
