use v5.38;

sub proc($s) {
    say "Input: $s";
    my @d = split '', $s;
    my @num;
    my $num = $d[0];
    for my $i (0 .. $#d - 1) {
	if ($d[$i] != $d[$i+1]) {
	    push @num, $num;
	    $num = $d[$i+1];
	} else {
	    $num .= $d[$i+1];
	}
    }
    push @num, $num;
    my $max = $num[0];
    for $num (@num) {
	$max = $num if ($num > $max);
    }
    say "Output: $max";
}

my $s = 6777133339;
proc($s);
$s = 1200034;
proc($s);
$s = 44221155;
proc($s);
$s = 88888;
proc($s);
$s = 11122233;
proc($s);
