use v5.38;
my $alph = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/";
my @a = split '', $alph;

sub value($val, $b) {
    if ($b < 10) {
	return $val;
    } else {
	if ($val < 10) {
	    return $val;
	} else {
	    return $a[$val - 10];
	}
    }
}

sub proc($num, $b) {
    say "Input: \$num = $num, \$base = $b";
    if ($b > 64) {
	say "Unsupported base size (max is 64)";
	return;
    }
    
    my $N = 0;
    while ($num / $b**$N > 1) {
	$N++;
    }
    my @v;
    for my $n (reverse (0 .. $N - 1)) {
	my $val = (int $num / $b**$n);
	if ((int $num / $b**$n) != 0) {
	    push @v, value($val, $b);
	} else {
	    push @v, 0;
	}
	$num %= $b**$n;
    }
    my $o = join '', @v;
    say "Output: $o";
}

my $num = 42;
my $base = 2;
proc($num, $base);

$num = 493;
$base = 8;
proc($num, $base);

$num = 15642094;
$base = 16;
proc($num, $base);

$num = 2228519;
$base = 36;
proc($num, $base);

$num = 123456789;
$base = 64;
proc($num, $base);
