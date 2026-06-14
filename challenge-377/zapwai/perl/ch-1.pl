use v5.38;

sub proc($s) {
    say "Input: $s";
    my $a = reverse($s);
    my @l = map{ substr $s, $_, 2 } (0 .. (length($s) - 2));
    my $out = "false";
    foreach my $l (@l) {
	$out = "true" if ($a =~ m/$l/);
    }
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
