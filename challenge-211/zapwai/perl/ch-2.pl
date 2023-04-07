use v5.30.0;
my @nums = (1 .. 8);
#my @nums = (1, 3);
say "Input: \@nums = (@nums)";
my $ans;
my @subarrays;
my $exp = $#nums + 1;
for (1 .. (2**$exp) - 2) {
    my $binary_number = sprintf '%'.$exp.'b', $_;
    my @pips = split "", $binary_number;
    my (@part1, @part2);
    for my $i (0 .. $#nums) {
	if ($pips[$i] == 1) {
	    push @part1, $nums[$i];
	} else {
	    push @part2, $nums[$i];	    
	}
    }
    my ($avg1, $avg2);
    for my $elem (@part1) {
	$avg1 += $elem;
    }
    for my $elem (@part2) {
	$avg2 += $elem;
    }
    $avg1 = $avg1 / ($#part1 + 1);
    $avg2 = $avg2 / ($#part2 + 1);    
    #    say "@part1 - @part2 ~ $avg1 - $avg2";
    if ($avg1 - $avg2 == 0) {
	$ans = 1;
	my $str = "(@part1)" . ' & ' . "(@part2) with avg $avg1";
	push @subarrays, $str;
    }
}
print "Output: ";
if ($ans) {
    say "true";
    say "e.g. $subarrays[0]";    
} else {
    say "false";
}
