use v5.38;

sub proc($path) {
    say "Input: $path";
    my ($x, $y) = (0,0);
    my $o = "false";
    for my $c (split '', $path) {
	if ($c eq "U") {
	    $y++;
	} elsif ($c eq "D") {
	    $y--;
	} elsif ($c eq "L") {
	    $x--;
	} else {
	    $x++;
	}
	if ($x == 0 && $y == 0) {
	    $o = "true";
	}
    }
    say "Output: $o";
}

my $path = "ULD";
proc($path);
$path = "ULDR";
proc($path);
$path = "UUURRRDDD";
proc($path);
$path = "UURRRDDLLL";
proc($path);
$path = "RRUULLDDRRUU";
proc($path);
