use v5.38;
my $coord = "d3";
proc($coord);
$coord = "g5";
proc($coord);
$coord = "e6";
proc($coord);

sub proc($coord) {
    say "Input: $coord";
    my ($l, $n) = split "", $coord;
    $l = lc $l;
    if ($l eq "a" or $l eq "c" or $l eq "e" or $l eq "g") {
	if ($n % 2 == 0) {
	    say "Output: True";
	} else {
	    say "Output: False";
	}
    } else {
	if ($n % 2 == 1) {
	    say "Output: True";
	} else {
	    say "Output: False";
	}
    }
}
