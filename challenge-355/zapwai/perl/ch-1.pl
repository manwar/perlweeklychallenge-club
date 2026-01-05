use v5.38;

sub proc($int) {
    say "Input: \$int = $int";
    my $o;
    my $len = length($int);
    if ($len <= 3) {
	$o = $int;
    } else {
	my @o;
	my @d = split '', $int;
	for my $i (0 .. $#d) {
	    my $j = $#d - $i;
	    push @o, $d[$j];
	    if ($i % 3 == 2) {
		push @o, ',';
	    }
	}
	$o = join '', reverse @o;
    }
    say "Output: $o";
}

my $int = 123;
proc($int);
$int = 1234;
proc($int);
$int = 1000000;
proc($int);
$int = 1;
proc($int);
$int = 12345;
proc($int);
