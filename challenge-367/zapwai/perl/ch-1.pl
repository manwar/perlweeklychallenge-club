use v5.38;

sub proc($s) {
    say "Input: \$str = $s";
    my @d = split '', $s;
    my ($ones, $zeros) = (0,0);
    for (@d) {
	if ($_ == 0) {
	    $zeros++;
	} elsif ($_ == 1) {
	    $ones++;
	} else {
	    say "Error - Nonbinary Number Detected";
	    exit;
	}
    }
    # Put a 1 in the ones place, then front-load all of the ones.
    my $output = "1" x ($ones - 1);
    $output .= "0" x $zeros;
    $output .= "1";
    say "Output: $output";
}

my $str = "1011";
proc($str);
$str = "100";
proc($str);
$str = "111000";
proc($str);
$str = "0101";
proc($str);
$str = "1111";
proc($str);
