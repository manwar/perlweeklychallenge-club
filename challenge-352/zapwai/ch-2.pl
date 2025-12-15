use v5.38;

sub to_dec(@l) {
    my $tot = 0;
    my $cnt = 0;
    for my $val (reverse @l) {
	my $pow = 2**$cnt++;
	$tot += $val*$pow;
    }
    return $tot;
}

sub proc(@nums) {
    say "Input: \@nums = @nums";
    my @ans;
    for my $i (0 .. $#nums) {
	my @l = @nums[0 .. $i];
	my $x = to_dec(@l);
	push @ans, ($x % 5 == 0) ? "true" : "false";
    }
    say "Output: @ans";
}

my @nums = (0,1,1,0,0,1,0,1,1,1);
proc(@nums);
@nums = (1,0,1,0,1,0);
proc(@nums);
@nums = (0,0,1,0,1);
proc(@nums);
@nums = (1,1,1,1,1);
proc(@nums);
@nums = (1,0,1,1,0,1,0,0,1,1);
proc(@nums);
