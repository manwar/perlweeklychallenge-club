use v5.38;

sub proc(@g) {
    say "Input: @g";
    my $lvl;
    my $max = $g[0];
    for my $val (@g) {
	$lvl += $val;
	if ($lvl > $max) {
	    $max = $lvl;
	}
    }
    $max = 0 if ($max < 0);
    say "Output: $max";
}

my @gain = (-5,1,5,-9,2);
proc(@gain);
@gain = (10,10,10,-25);
proc(@gain);
@gain = (3,-4,2,5,-6,1);
proc(@gain);
@gain = (-1, -2, -3, -4);
proc(@gain);
@gain = (-10, 15, 5);
proc(@gain);

