use v5.30;
use List::Util qw(sum max min);
use Math::Combinatorics;
my @nums = (2,1,4);
my $sum = 0;
for my $cnt (1 .. @nums) {
    my $comb = Math::Combinatorics->new(
	count => $cnt,
	data => [@nums]
    );
    while (my @combo = $comb->next_combination) {
	#	say @combo," --> ", pow(@combo);
	$sum += pow(@combo);
    }
}
sub pow {
    my $m = min @_;
    my $M = max @_;
    return $m*$M**2;
}
say "Input : \@nums = (" .join(", ",@nums).")";
say "Output: $sum";
