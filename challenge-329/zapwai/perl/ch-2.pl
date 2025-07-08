use v5.38;

sub proc($str) {
    say " Input: $str";
    my @chunks;
    my $on = 0;
    my @l = split '', $str;
    my $strip;
    for my $i (0 .. $#l - 1) {
	if (lc($l[$i]) eq lc($l[$i+1])) {
	    if ($on == 1) {
		$strip .= $l[$i+1];
	    } else {
		$on = 1;
		$strip = $l[$i].$l[$i+1];
	    }
	} else {
	    if ($on == 1) {
		$on = 0;
		push @chunks, $strip;
		$strip = '';
	    }
	}
    }
    if ($strip && $on) {
	push @chunks, $strip;
    }
    print "Output: ";
    if (@chunks) {
	my ($max, $max_index) = (0, 0);
	for my $i (0 .. $#chunks) {
	    if ($max < length $chunks[$i]) {
		$max = length $chunks[$i];
		$max_index = $i;
	    }
	}
	print $chunks[$max_index];
    }
    print "\n";
}

my $str = "YaaAho";
proc($str);

$str = "cC";
proc($str);

$str = "A";
proc($str);
