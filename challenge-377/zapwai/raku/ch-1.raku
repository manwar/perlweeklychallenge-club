use v6;

sub proc($s) {
    say "Input: \$s = $s";
    my $a = $s.flip;
    my @l = (0 .. $s.chars - 2).map({substr $s, $_, 2});
    my $out = @l.grep({ $a.contains($_) }).elems ?? "true" !! "false";
    say "Output: $out";
}

my $s = "abcba";
proc($s);
$s = "racecar";
proc($s);
$s = "abcd";
proc($s);
$s = "banana";
proc($s);
$s = "hello";
proc($s);
