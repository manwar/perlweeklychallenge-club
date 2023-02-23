use v5.30.0;
my @array = (5,3,4,4);
say "Input: \@array = (".join(",",@array).")";
print "Output: ";
@array = sort @array;
sub third {
    my @l = @_;
    my $max1 = $l[$#l];
    unless ( defined $max1 ) {
	say "Highest value is NULL";
	return;
    }
    my $max2;
    for (0..$#l) {
	if ($l[$#l-$_] != $max1) {
	    $max2 = $l[$#l-$_];
	    last;
	}
    }
    unless (defined($max2)) {
	say "Highest value is $max1";
	return;
    }
    my $max3;    
    for (0..$#l) {
	if (($l[$#l-$_] != $max1) and ($l[$#l-$_] != $max2)) {
	    $max3 = $l[$#l-$_];
	    last;
	}
    }
    unless (defined($max3)) {
	say "Highest value is $max1, second highest is $max2.";
	return;
    }
    say $max3."\n\t[In order, highest to lowest top 3 values: ($max1, $max2, $max3)]";
}
third(@array);
