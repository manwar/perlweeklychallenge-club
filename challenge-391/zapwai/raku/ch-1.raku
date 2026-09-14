use v6;

sub swish($p, @a) {
    my $flag = 0;
    while (@a.elems > $p) {
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
    @a = sort @a;
    if (@a.elems == 1) {
	return @a[0];
    } elsif (@a.elems == 2) {
	return (@a[0] + @a[1])/2;
    } elsif (@a.elems == 0) {
	return;
    }
    if (@a.elems % 2 == 0) {
	@a = swish(2, @a);
	return (@a[0] + @a[1])/2;
    } else {
	@a = swish(1, @a);
	return @a[0];
    }
}

sub proc(@arr1, @arr2) {
    say "Input: \@arr1 = @arr1, \@arr2 = @arr2";
    my @a;
    @a.push(|@arr1, |@arr2);
    @a = @a.sort();
    say "Output: ", process(@a);
}

my @arr1 = (2); my @arr2 = (4);
proc(@arr1, @arr2);
   
@arr1 = (); @arr2 = (10,20,30,40);
proc(@arr1, @arr2);

@arr1 = (100); @arr2 = (1 .. 7);
proc(@arr1, @arr2);

@arr1 = (1,2,2); @arr2 = (2,2,3);
proc(@arr1, @arr2);
