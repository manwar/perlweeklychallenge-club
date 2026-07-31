use v5.38;
use List::Util "uniq";

# Check if word is grouped consecutively
sub grouped($word) {
    my $len = length $word;
    my $k = $len/2;
    my $c = substr($word, 0, 1);
    for my $i (0 .. $k - 1) {
	if (substr($word, $i, 1) != $c) {
	    return 0;
	}
    }
    return 1;
}

sub equal_count($word) {
    my ($zero, $one) = (0, 0);
    my @d = split '', $word;
    foreach my $val (@d) {
	if ($val == 0) {
	    $zero++;
	} else {
	    $one++;
	}
    }
    return ($zero == $one);
}

sub proc($b) {
    say "Input: \$binary = $b";
    my @o;
    for my $i (0 .. length($b) - 2) {
	for my $j (1 .. length($b) - $i) {
	    my $word = substr($b, $i, $j);
	    if (equal_count($word)) {
		if (grouped($word)) {
		    push @o, $word;
		}
	    }
	}
    }
    @o = uniq @o;
    say "Output: @o";
}

my $binary = "0101";
proc($binary);
$binary = "000111";
proc($binary);
$binary = "000011";
proc($binary);
$binary = "10011100";
proc($binary);
$binary = "00000";
proc($binary);
