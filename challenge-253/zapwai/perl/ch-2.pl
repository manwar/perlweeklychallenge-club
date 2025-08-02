use v5.30;

my @m = (
    [1, 1, 0, 0, 0],
    [1, 1, 1, 1, 0],
    [1, 0, 0, 0, 0],
    [1, 1, 0, 0, 0],
    [1, 1, 1, 1, 1]
);

# @m = (
#     [1, 0, 0, 0],
#     [1, 1, 1, 1],
#     [1, 0, 0, 0],
#     [1, 0, 0, 0]
# );

my %freq;
foreach my $row (0 .. $#m) {
    for my $val (@{$m[$row]}) {
	$freq{$row}++ if ($val == 1);
    }
}

my @ind = (0 .. -1 + scalar keys %freq);

my $cnt = 0;
do {
    $cnt = 0;
    for my $i (0 .. $#ind - 1) {
	if (is_weaker($ind[$i],$ind[$i + 1])) {
	   $cnt++;
	   my $ind = $ind[$i];
	   $ind[$i] = $ind[$i + 1];
	   $ind[$i + 1] = $ind;
	}
    }
} while ($cnt);
say join(", ",reverse @ind);

sub is_weaker {			# return 1 if row i is less than row j
    my ($i, $j) = @_;
    if ($freq{$i} < $freq{$j}) {
	return 1;
    } elsif ($freq{$i} > $freq{$j}) {
	return 0;
    } else {
	return ($i < $j) ? 1 : 0;
    }
}