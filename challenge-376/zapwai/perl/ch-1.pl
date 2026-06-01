use v5.38;

sub color($cell) {
    my ($letter, $number) = split '', $cell;
    my @letter = qw( a b c d e f g h );
    $number--;
    my $letnum;
    for my $i (0 .. $#letter) {
	if ($letter[$i] eq $letter) {
	    $letnum = $i;
	    last;
	}
    }
    if (($letnum + $number) % 2 == 0) {
	return "black"
    } else {
	return "white";
    }
}

sub proc($c1, $c2) {
    say "Input: \$c1 = $c1, \$c2 = $c2";
    print "Output: ";
    if (color($c1) eq color($c2)) {
	say "true";
    } else {
	say "false";
    }
}

my $c1 = "a7"; my $c2 = "f4";
proc($c1, $c2);
$c1 = "c1"; $c2 = "e8";
proc($c1, $c2);
$c1 = "b5"; $c2 = "h2";
proc($c1, $c2);
$c1 = "f3"; $c2 = "h1";
proc($c1, $c2);
$c1 = "a1"; $c2 = "g8";
proc($c1, $c2);
