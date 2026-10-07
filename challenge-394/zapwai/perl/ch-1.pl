use v5.38;

sub swaps_for_pattern($s, $upper_first) {
    my @c = split '', $s;

    # Positions that need uppercase letters in the target
    my @target_upper;
    for my $i (0 .. $#c) {
        my $want_upper = $upper_first
            ? $i % 2 == 0
            : $i % 2 == 1;

        push @target_upper, $i if $want_upper;
    }

    # Actual positions of uppercase letters
    my @actual_upper;
    for my $i (0 .. $#c) {
        push @actual_upper, $i if $c[$i] =~ /[A-Z]/;
    }

    # Moving each uppercase letter to its target position.
    my $swaps = 0;

    for my $i (0 .. $#actual_upper) {
        $swaps += abs($actual_upper[$i] - $target_upper[$i]);
    }

    return $swaps;
}

sub proc($str) {
    my $a = swaps_for_pattern($str, 1);
    my $b = swaps_for_pattern($str, 0);

    say "Input:  $str";
    say "Swaps:  ", $a < $b ? $a : $b;
}

my $str = "aAbB";
proc($str);
$str = "AAbb";
proc($str);
$str = "AAAbbb";
proc($str);
$str = "aABb";
proc($str);
$str = "bBBAaa";
proc($str);
