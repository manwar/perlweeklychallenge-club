use v5.38;
sub proc($s) {
    say "Input: $s";
    $s =~ s/\s+//g if ($s =~ /\s/);
    my @digit = split "", $s;
    my $payload = pop @digit;
    @digit = reverse @digit;
    my $sum = 0;
    for my $i (0 .. $#digit) {
	if ($i % 2 == 0) {
	    my $x = 2*$digit[$i];
	    if ($x > 9) {
		my $a = int $x / 10;
		my $b = $x % 10;
		$sum += $a + $b;
	    } else {
		$sum += $x;
	    }
	} else {
	    $sum += $digit[$i];
	}
    }
    my $ans = "false";
    $ans = "true" if (($sum + $payload) % 10 == 0);
    say "Output: $ans";
    
}

my $s = "17893729974";
proc($s);

$s = "4137 8947 1175 5904";
proc($s);
$s = "4137 8974 1175 5904";

proc($s);
