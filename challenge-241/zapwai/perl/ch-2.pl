use v5.30;
my @int = (11, 8, 27, 4);
say "Input: \@int = (". join(", ", @int) . ")";
my $max = 0;
foreach my $v (@int) {
    $max = $v if ($v > $max);
}
my @prime = myprimes($max);
my @factor = map {factors($_)} @int;
my @ans = @int;
my $flag = 0;
do {
    $flag = 0;
    foreach my $i (0 .. $#factor - 1) {
	if ( ($factor[$i] > $factor[$i + 1]) ||
	     ( ($factor[$i] == $factor[$i+1]) && ($ans[$i] > $ans[$i+1]) )
	 ) {
	    $flag++;
	    my $aval = $ans[$i];
	    my $fval = $factor[$i];
	    $ans[$i] = $ans[$i+1];
	    $ans[$i + 1] = $aval;
	    $factor[$i] = $factor[$i+1];
	    $factor[$i+1] = $fval;
	}
    }
} while ($flag);
print "Output: (";
say join(", ",@ans) . ")";
sub factors {
    my $num = shift;
    my @list;
    do {
	foreach my $factor (@prime) {
	    if ( $num % $factor == 0 ) {
		push @list, $factor;
		$num = $num / $factor;
	    }
	}
    } while ($num != 1);
    return $#list+1;
}

sub myprimes {
    my $N = shift;
    my @p = (2);
    for my $i (3 .. $N) {
	push @p, $i if is_prime($i);
    }
    @p
}

sub is_prime {
    my $num = shift;
    for my $i (2 .. sqrt($num)) {
	return 0 if ( $num % $i == 0 );
    }
    1
}
