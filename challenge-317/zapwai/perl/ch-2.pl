use v5.38;

# Return list of all words formed by swapping two letters of $s
sub swaplist($s) {
    my @let = split '', $s;
    my @l;
    for my $i (0 .. $#let - 1) {
	for my $j ($i + 1 .. $#let) {
	    my $word;
	    for my $k (0 .. $#let) {
		if ($k == $i) {
		    $word .= $let[$j];
		} elsif ($k == $j) {
		    $word .= $let[$i];
		} else {
		    $word .= $let[$k];
		}
	    }
	    push @l, $word;
	}
    }
    return @l;
}

# Return true if swapping a pair of letters makes them match
sub swappy($s, $r) {
    return 0 if (length $s != length $r);
    for my $sw (swaplist($s)) {
	return 1 if ($sw eq $r);
    }
    return 0;
}

sub proc($str1, $str2) {
    say "Input: \$str1 = $str1, \$str2 = $str2";
    say "Output: ", swappy($str1, $str2) ? "true" : "false";
}

my $str1 = "desc"; my $str2 = "dsec";
proc($str1, $str2);
$str1 = "fuck"; $str2 = "fcuk";
proc($str1, $str2);
$str1 = "poo"; $str2 = "eop";
proc($str1, $str2);
$str1 = "stripe"; $str2 = "sprite";
proc($str1, $str2);

