use v6;

my @tests = [1.2, 0.4, 0.1, 2.5],
            [0.2, 1.5, 0.9, 1.1],
            [0.5, 1.1, 0.3, 0.7],
            [0.7, 4.3, -0.1, 1.1];
for @tests -> @R {
    my $found = False;
    say "Testing: @R[]";
    for @R.combinations(3) -> $candidate {
        $found = True and say $candidate
      if 1 < $candidate.sum < 2;
    }
    say +$found;
}
