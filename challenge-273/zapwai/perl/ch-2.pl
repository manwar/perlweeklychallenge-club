use v5.38;
my $str = "aabb";
proc($str);
$str = "abab";
proc($str);
$str = "aaa";
proc($str);
$str = "bbb";
proc($str);

sub proc($str) {
    say "Input: \$str = $str";
    my $ver = 0;
    if ($str =~ /b/) {
	$ver = 1;
	my $bflag = 0;
	for my $l (split "", $str) {
	    if ($l eq "a" and $bflag) {
		$ver = 0;
		last;
	    } else {
		if ($l eq "b") {
		    $bflag = 1;
		}
	    }
	}
    }
    say "Output: ", $ver ? "true" : "false";
}
