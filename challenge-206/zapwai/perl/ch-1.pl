use v5.30.0;
my @time = ("00:00", "23:55", "20:00");
#my @time= ("01:01", "00:50", "00:57");
#my @time=("10:10", "09:30", "09:00", "09:55");
print "Input: \@time = (".join(", ",@time).")\nOutput: ";
my @MIN;
foreach (@time) {
    my ($hr, $mn) = split(":",$_);
    push @MIN, $hr*60 + $mn;
}
my $min = 60*24;
my ($ind1,$ind2);
for my $i ( 0 .. $#MIN - 1) {
    for my $j ( $i + 1 .. $#MIN) {
	my $diff = abs $MIN[$i] - $MIN[$j];
	$diff = 60*24 - $diff if ($diff > 30*24);
	if ($min > $diff) {
	    $min = $diff;
	    $ind1 = $i;
	    $ind2 = $j;
	}
    }
}
say "$min\n$min min is the difference between times $time[$ind1] and $time[$ind2]";
