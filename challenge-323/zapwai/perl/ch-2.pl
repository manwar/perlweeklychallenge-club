use feature qw( say signatures );

sub proc($income, @tax) {
    print "Input: \$income = $income, \n\t\@tax = ";
    print "( ";
    print '[' . join(", ", @$_) . '] ' for (@tax);
    say ")";

    my $tax = 0;
    my $prev = 0;
    for (@tax) {
	my ($cap, $perc) = @$_;
	if ($income >= $cap) {
	    $tax += ($cap - $prev)*$perc/100.0;
	    $prev = $cap;
	} else {
	    $tax += ($income - $prev)*$perc/100.0;
	    last;
	}
    }
    say "Output: $tax";
}

my $income = 10; my @tax = ([3, 50], [7, 10], [12,25]);
proc($income, @tax);
$income = 2; @tax = ([1, 0], [4, 25], [5,50]);
proc($income, @tax);
$income = 0; @tax = ([2, 50]);
proc($income, @tax);
