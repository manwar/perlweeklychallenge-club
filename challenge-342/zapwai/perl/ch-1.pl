use v5.38;

sub proc($str) {
    say "Input: $str";
    my @num;
    my @let;
    for my $l (split '', $str) {
	if ($l =~ /\d/) {
	    push @num, $l;
	} else {
	    push @let, $l;
	}
    }

    if (abs(scalar @num - scalar @let) >= 2) {
	say "Output: \"\"";
    } else {
	my $o;
	if (scalar @num > scalar @let) {
	    $o = $num[0];
	    for my $i (0 .. $#let) {
		$o = $o.$let[$i].$num[$i+1];
	    }
	} else {
	    $o = $let[0];
	    for my $i (0 .. $#num) {
		$o = $o.$num[$i].$let[$i+1];
	    }
	}
	say "Output: \"$o\"";
    }
    
}

my $str = "a0b1c2";
proc($str);
$str = "abc12";
proc($str);
$str = "0a1b2c3";
proc($str);
$str = "1a23";
proc($str);
$str = "ab123";
proc($str);

## Champion of the week! Yay! Thank you PWC and M. Anwar :-)
