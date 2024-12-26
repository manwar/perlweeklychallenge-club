use v5.38;
sub hamdist($x, $y) {
    my $len = ($x > $y) ? length sprintf("%b", $x) : length sprintf("%b", $y);
    my $format = "%0$len"."b";
    my $X = sprintf($format, $x);
    my $Y = sprintf($format, $y);
    my @dx = split "", $X;
    my @dy = split "", $Y;
    my $sum = 0;
    for (0 .. $#dx) {
	$sum++ if abs($dx[$_] - $dy[$_]) > 0;
    }
    return $sum;
}
sub proc(@ints) {
    say "Input: \@ints = @ints";
    my $ham = 0;
    for my $i (0 .. $#ints - 1) {
	for my $j ($i + 1 .. $#ints) {
	    $ham += hamdist($ints[$i], $ints[$j]);
	}
    }
    say "Output: $ham";
}
my @ints = (4, 14, 2);
proc(@ints);
@ints = (4, 14, 4);    
proc(@ints);