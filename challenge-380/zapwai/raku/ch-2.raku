use v6;

sub rev_ind($c) {
    my $alph = "abcdefghijklmnopqrstuvwxyz";
    return 26 - index $alph, $c;
}

sub proc($s) {
    say "Input: \$str = \"$s\"";
    my @char = $s.comb;
    my $sum = 0;
    $sum += ($_ + 1) * rev_ind(@char[$_]) for 0 .. @char.end;
    say "Output: $sum";
}

my $s = "z";
proc($s);
$s = "a";
proc($s);
$s = "bbc";
proc($s);
$s = "racecar";
proc($s);
$s = "zyx";
proc($s);
