use v5.38;

sub proc($str) {
    say "Input: $str";
    my $ind = 0;
    my $flag = 1;
    my $o = $str;
    while ($flag) {
	my @l = split '', $o;
	if ($o =~ /\d/) {
	    if ($l[0] =~ /\d/) {
		$flag = 0;
	    } else {
		for my $i (0 .. $#l - 1) {
		    if ($l[$i+1] =~ /\d/) {
			$o = substr($o, 0, $i).substr($o, $i + 2);
			last;
		    }
		}
	    }
	} else {
	    $flag = 0;
	}
    }
    say "Output: $o";
}

my $str = "cab12";
proc($str);

$str = "xy99";
proc($str);

$str = "pa1erl";
proc($str);
