use v5.38;

sub proc($x, $y, @int) {
    say "Input: @int\t \$x = $x\t \$y = $y";
    my $sum = 0;
    for my $i ($x .. $y) {
	$sum += $int[$i];
    }
    say "Output: $sum";
}

my @ints = (-2, 0, 3, -5, 2, -1);
my $x = 0;
my $y = 2;
proc($x, $y, @ints);
@ints = (1, -2, 3, -4, 5); $x = 1; $y = 3;
proc($x, $y, @ints);
@ints = (1, 0, 2, -1, 3); $x = 3; $y = 4;
proc($x, $y, @ints);
@ints = (-5, 4, -3, 2, -1, 0); $x = 0; $y = 3;
proc($x, $y, @ints);
@ints = (-1, 0, 2, -3, -2, 1); $x = 0; $y = 2;
proc($x, $y, @ints);
