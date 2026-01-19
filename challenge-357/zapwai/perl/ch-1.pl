use v5.38;

sub big($int) {
    my @d = split '', $int;
    @d = sort { $b <=> $a } @d;
    return join('', @d);
}

sub small($int) {
    my @d = split '', $int;
    @d = sort { $a <=> $b } @d;
    return join('', @d);
}

sub proc($int) {
    say "Input: $int";
    my $o = "";
    if ($int == 6174) {
	$o = "0";
    } else {
	my $diff = big($int) - small($int);
	unless ($o) {
	    if ($diff == 0) {
		$o = -1;
	    } else {
		while (length $diff < 4) {
		    $diff = "0".$diff;
		}
		if ($diff == 6174) {
		    $o = "1";
		}
	    }
	}
	unless ($o) {
	    my $cnt = 1;
	    while ($diff != 6174) {
		$cnt++;
		$diff = big($diff) - small($diff);
	    }
	    $o = $cnt;
	}
    }
    say "Output: $o";
}

my $int = 3524;
proc($int);
$int = 6174;
proc($int);
$int = 9998;
proc($int);
$int = 1001;
proc($int);
$int = 9000;
proc($int);
$int = 1111;
proc($int);
