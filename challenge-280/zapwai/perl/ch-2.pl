use v5.38;
my $str = "p|*e*rl|w**e|*ekly|";
proc($str);
$str = "perl";
proc($str);
$str = "th|ewe|e**|k|l***ych|alleng|e";
proc($str);
sub proc($str) {
    say "Input: $str";
    my $cnt = 0;
    my @words = split('\|', $str);
    for my $i (0 .. $#words) {
	if ($i % 2 == 0) {
	    my @letters = split("", $words[$i]);
	    $cnt += grep { $_ eq "*" } @letters;
	}
    }
    say "Output: $cnt";
}
