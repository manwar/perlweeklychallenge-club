use v5.38;
use List::Util "sum";

sub digit_sum(@ints) {
    my $sum = 0;
    foreach (@ints) {
	my @p = split "", $_;
	$sum += $_ foreach (@p);
    }
    return $sum;
}

my @ints = (1,2,3,45);
say "Input: @ints";
say "Output: ", abs(digit_sum(@ints) - sum @ints);
