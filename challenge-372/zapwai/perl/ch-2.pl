use v5.38;

sub proc($s) {
    say "Input: $s";
    my %h;
    my @s = split '', $s;
    for my $i (0 .. $#s - 1) {
	my $letter = $s[$i];
	my $next = 0;
	foreach my $key (keys %h) {
	    $next = 1 if ($letter eq $key);
	}
	next if ($next);
	my $diff = -1;
	for my $j ($i + 1 .. $#s) {
	    my $new_letter = $s[$j];
	    if ($new_letter eq $letter) {
		my $new_diff = $j - $i - 1;
		$diff = $new_diff if ($new_diff > $diff);
	    }
	}
	$h{$letter} = $diff;
    }
    my $max = -1;
    foreach my $val (values %h) {
	$max = $val if ($max < $val);
    }
    say "Output: $max";
}

my $s = "aaaaa";
proc($s);
$s = "abcdeba";
proc($s);
$s = "abbc";
proc($s);
$s = "abcaacbc";
proc($s);
$s = "laptop";
proc($s);
