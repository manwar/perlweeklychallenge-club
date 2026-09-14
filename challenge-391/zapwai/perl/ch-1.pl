use v5.38;

sub swish($p, @a) {
    my $flag = 0;
    while (scalar @a > $p) {
	if ($flag == 0) {
	    $flag = 1;
	    pop @a;
	} else {
	    $flag = 0;
	    shift @a;
	}
    }
    return @a;
}

sub process(@a) {
    @a = sort {$a <=> $b} @a;
    if (scalar @a == 1) {
	return $a[0];
    } elsif (scalar @a == 2) {
	return ($a[0] + $a[1])/2;
    } elsif (scalar @a == 0) {
	return;
    }
    if (scalar @a % 2 == 0) {
	@a = swish(2, @a);
	return ($a[0] + $a[1])/2;
    } else {
	@a = swish(1, @a);
	return $a[0];
    }
}

sub proc(@a) {
    say "Output: ", process(@a);
}

my @arr1 = (2);
my @arr2 = (4);
say "Input: \@arr1 = @arr1, \@arr2 = @arr2";
proc(@arr1, @arr2);
   
@arr1 = (); @arr2 = (10,20,30,40);
say "Input: \@arr1 = @arr1, \@arr2 = @arr2";
proc(@arr1, @arr2);

@arr1 = (100); @arr2 = (1 .. 7);
say "Input: \@arr1 = @arr1, \@arr2 = @arr2";
proc(@arr1, @arr2);

@arr1 = (1,2,2); @arr2 = (2,2,3);
say "Input: \@arr1 = @arr1, \@arr2 = @arr2";
proc(@arr1, @arr2);
