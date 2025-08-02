use feature qw(signatures say);

sub p($s) {
    my @d = split '', $s;
    my @o;
    for (@d) {
	if ($_ eq '#') {
	    pop @o;
	} else {
	    push @o, $_;
	}
    }
    return join '', @o;
}

sub proc($str1, $str2) {
    say "Input: $str1, $str2";
    my $s1 = p($str1);
    my $s2 = p($str2);
    say "Output: ", ($s1 eq $s2) ? 'true' : 'false';
}

$str1 = "ab#c";
$str2 = "ad#c";
proc($str1, $str2);

$str1 = "ab##";
$str2 = "a#b#";
proc($str1, $str2);

$str1 = "a#b";
$str2 = "c";
proc($str1, $str2);
