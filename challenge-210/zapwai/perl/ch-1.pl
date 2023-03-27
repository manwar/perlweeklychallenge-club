use v5.30.0;
my @int = (2, 3, 1);
#my @int = (1,1,2,2, 3, 2);
say "Input:  \@int = (".join(", ",@int).")";    
my %freq;
$freq{$_}++ for (@int);
my $max;
my $val;
foreach my $key (keys %freq) {
    my $sum = 0;
    for (-1 .. 1) {
	my $n = $key + $_;
	$sum += $n*$freq{$n};
    }
    if ($max < $sum) {
	$val = $key;
	$max = $sum;
    }
}
say "Output: $max (by removing $val)";
