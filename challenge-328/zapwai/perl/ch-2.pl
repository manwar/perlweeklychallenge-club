use v5.38;

sub where_badspot($s) {
    my @l = split '', $s;
    for my $i (0 .. $#l - 1) {
	my $let = $l[$i];
	my $next_let = $l[$i+1];
	if ($let eq uc($let)) {
	    return $i if (lc($let) eq $next_let)
	} else {
	    return $i if (uc($let) eq $next_let);
	}
    }
    return -1;
}

sub strip_it($s, $badspot) {
    my $out = substr $s, 0, $badspot;
    $out .= substr $s, $badspot + 2;
    return $out;
}

sub proc($str) {
    say " Input: $str";
    my $out = $str;
    my $clear_flag = 0;
    while ($clear_flag == 0) {
	my $badspot = where_badspot($out);

	if ($badspot != -1) {
	    $out = strip_it($out, $badspot);
	} else {
	    $clear_flag = 1;
	}
    }
    say "Output: $out";
}

my $str = "WeEeekly";
proc($str);

$str = "abBAdD";
proc($str);

$str = "abc";
proc($str);
