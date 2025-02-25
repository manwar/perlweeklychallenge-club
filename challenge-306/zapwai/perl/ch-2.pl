use v5.38;
use List::Util qw( max );

sub drop2($ind1, $ind2, @l) {
	if ($ind1 > $ind2) {
	    splice @l, $ind1, 1;
	    splice @l, $ind2, 1;
	} else {
	    splice @l, $ind2, 1;
	    splice @l, $ind1, 1;
	}
    
    return @l;
}

sub churn(@l) {
    my $max1 = max(@l);
    my $max2 = 0;
    my ($ind1, $ind2) = (0, 0);
    my $found = 0;
    for my $i (0 .. $#l) {
	if ($found) {
	    if ($max2 < $l[$i]) {
		$max2 = $l[$i];
		$ind2 = $i;
	    }
	} else {
	    if ($l[$i] == $max1) {
		$found = 1;
		$ind1 = $i;
		next;
	    } else {
		if ($max2 < $l[$i]) {
		    $max2 = $l[$i];
		    $ind2 = $i;
		}
	    }
	}
    }
    $found = 0;
    if ($max1 == $max2) {
	@l = drop2($ind1, $ind2, @l);
    } else {
	my $newval = $max1 - $max2;
	@l = drop2($ind1, $ind2, @l);
	push @l, $newval;
    }
    return @l;
}

sub proc(@ints) {
    say "Input: \@ints = @ints";
    do {
	@ints = churn(@ints);
    } while (@ints > 1);
    print "Output: ";
    say $ints[0] // 0;
}

my @ints = (3, 8, 5, 2, 9, 2);
proc(@ints);
@ints = (3, 2, 5);
proc(@ints);
