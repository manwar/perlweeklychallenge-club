use v5.38;

sub strip($s) {
    my @l = split '', $s;
    my $bad_index = "-1";
    for my $i (0 .. $#l - 1) {
	if ($l[$i] eq $l[$i+1]) {
	    $bad_index = $i;
	    last;
	}
    }
    if ($bad_index == -1) {
	return $s;
    } else {
	splice @l, $bad_index, 2;
	return join '', @l;
    }
}

sub proc($s) {
    say "Input: $s";
    while (1) {
	my $pre = $s;
	$s = strip($s);
	last if ($pre eq $s);
    }
    say "Output: $s";
}

my $str = "abbaca";
proc($str);
$str = "azxxzy";
proc($str);
$str = "aaaaaaaa";
proc($str);
$str = "aabccba";
proc($str);
$str = "abcddcba";
proc($str);
