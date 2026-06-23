use v5.38;
my $limit = 1000;

sub proc($base) {
    say "Input: \$base = $base, \$limit = $limit";
    my @armstrong;
    for my $number (0 .. $limit) {
	my $x = $number;
	my $num = ($number == 0) ? 0 : '';
	while ($x > 0) {
	    my $rem = $x % $base;
	    $num = $rem . $num;
	    $x = int($x / $base);
	}
	my @d = split '', $num;
	my $sum = 0;
	my $len = scalar @d;
	for my $d (@d) {
	    $sum += $d**$len;
	}
	push @armstrong, $number if ($sum == $number);
    }
    say "Output: @armstrong";
}

my $base = 10;
proc($base);
$base = 7;
proc($base);
$base = 16;
proc($base);
