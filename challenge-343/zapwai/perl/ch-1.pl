use v5.38;

sub proc(@n) {
    say "Input: (@n)";
    my $min = abs($n[0]);
    for my $val (@n) {
	$min = abs($val) if (abs($val) < $min);
    }
    say "Output: $min";
}

my @nums = (4,2,-1,3-2);
proc(@nums);
@nums = (-5, 5, -3, 3, -1, 1);
proc(@nums);
@nums = (7, -3, 0, 2, -8);
proc(@nums);
@nums = (-2, -5, -1, -8);
proc(@nums);
@nums = (-2, 2, -4, 4, -1, 1);
proc(@nums);
