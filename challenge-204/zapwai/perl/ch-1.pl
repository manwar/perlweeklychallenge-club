use v5.30.0;
my @nums = (1,2,4);
say "Input: \@nums: (".join(",",@nums).")";
say "Output: " . is_monotonic(@nums);
sub is_monotonic {
    my @list = @_;
    my $ascend = 0;
    foreach (1 .. $#list) {
	next if ($list[$_] - $list[$_-1] == 0);
	if ($list[$_] > $list[$_ - 1]) {
	    $ascend = 1;
	    last;
	}
	else {
	    $ascend = -1;
	    last;
	}
    }
    return 1 if ($ascend == 0);	# list of constant value
    foreach (1 .. $#list) {
	if ($ascend == 1) {
	    return 0 if ($list[$_] < $list[$_ - 1]);
	}
	else {
	    return 0 if ($list[$_] > $list[$_ - 1]);
	}
    }
    1
}
