use v5.30;
my @int = (3,4,2);
say "Input: \@int = (" . join(",",@int) .")";
print "Output: ";
my $c = run(@int);
say $c;
sub run {
    my @l = @_;
    my $cnt = 0;
    do {
	if ( min(@l) == $l[0] ) {
	    shift @l;
	} else {
	    my $r =  shift @l;
	    push @l, $r;
	}
	$cnt++;
    } while (@l);
    return $cnt;
}
sub min {
    my @l = @_;
    my $min = 1000000;
    for (@l) {
	$min = $_ if ($min > $_);
    }
    return $min;
}
