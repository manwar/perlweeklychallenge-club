use v5.30.0;
my @numbers = (1,0,0,0,1);
my $count = 1;
say "Input: \@numbers = (" . join(",", @numbers) . "), \$count = $count";
print "Output: ";
sub spaces {
    my $n = shift;
    return 0 if ($n < 0);
    if ($n % 2 == 0) {
	($n - 2) / 2
    } else {
	($n - 1) / 2
    }
}

my $land;
my $water;
my $length = 0;
my $total;
foreach (0 .. $#numbers) {
    if ($numbers[$_] != '0') {
	$land = 1;
	if ($water) {
	    $total += spaces($length);
	    $water = 0;
	}

    } else {
	$length++;
	if ($land) {
	    $land = 0;
	    $water = 1;
	}
    }
}

my $ans = ($count <= $total) || 0;
say $ans;
say "There is room for $total placements.";
