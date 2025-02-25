use v5.38;

sub is_above_zero($n, @l) {
    my $sum = $n;
    for (@l) {
	return 0 if ($sum < 1);
	$sum += $_;
    }
    return 0 if ($sum < 1);
    1
}

sub proc(@ints) {
    say "Input: @ints";
    my $flag = 1;
    my $lvl = 0;
    do {
	$lvl++;
	$flag = 0 if (is_above_zero($lvl, @ints));
    } while ($flag);
    say "Output: $lvl";
	
}

my @ints = (-3, 2, -3, 4, 2);
proc(@ints);

@ints = (1,2);
proc(@ints);

@ints = (1, -2, -3);
proc(@ints);
