use v5.38;
my $str = "abcddbca";
proc($str);
$str = "abcd";
proc($str);
$str = "abcdabbb";
proc($str);
sub proc($str) {
    say "Input: $str";
    my $letter = "";
    my @letters = split("", $str);
    my @gotten;
    for my $l  (@letters) {
	for my $g (@gotten) {
	    if ($l eq $g) {
		$letter = $l;
	    }
	}
	if ($letter ne "") {
	    last;
	} else {
	    push @gotten, $l;
	}
    }
    say "Output: $letter";
}
