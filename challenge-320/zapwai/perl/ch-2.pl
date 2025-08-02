use v5.38;
use List::Util qw(sum);
sub proc(@ints) {
    say "Input: @ints";
    my @p;
    for my $num (@ints) {
	if ($num < 10) {
	    push @p, $num;
	} else {
	    my @l = split '', $num;
	    push @p, @l;
	}
    }
    my $elem = sum(@ints);
    my $dig = sum(@p);
    say "Output: ", abs($elem - $dig);
}
my @ints = (1,23,4,5);
proc(@ints);
@ints = (1,2,3,4,5);
proc(@ints);
@ints = (1,2,34);
proc(@ints);
