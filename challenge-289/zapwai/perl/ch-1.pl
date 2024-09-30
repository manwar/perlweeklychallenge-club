use v5.38;
use List::Util qw( max );

my @ints = (5, 6, 4, 1);
proc(@ints);
@ints = (4, 5);
proc(@ints);
@ints = (1, 2, 2, 3);
proc(@ints);

sub proc(@ints) {
    say "Input: @ints";
    my $ans = max(@ints);
    my @new1;
    for my $i (0 .. $#ints) {
	unless ($ints[$i] == $ans) {
	    push @new1, $ints[$i];
	}
    }
    if (@new1 > 0) {
	my $m2 = max(@new1);
	my @new2;
	for my $i (0 .. $#new1) {
	    unless ($new1[$i] == $m2) {
		push @new2, $new1[$i];
	    }
	}
	if (@new2 > 0) {
	    $ans = max(@new2);
	}
    }
    say "Output: $ans";
}
