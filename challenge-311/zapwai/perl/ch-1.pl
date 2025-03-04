use v5.38;
sub proc($str) {
    say "Input: \$str = $str";
    my $o;
    for (split '', $str) {
	if ($_ =~ /[a-z]/) {
	    $o .= uc $_;
	} else {
	    $o .= lc $_;
	}
    }
    say "Output: $o";
}

my $str = "pERl";
proc($str);
$str = "rakU";
proc($str);
$str = "PyThOn";
proc($str);
