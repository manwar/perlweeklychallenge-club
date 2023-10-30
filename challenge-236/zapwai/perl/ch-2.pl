use v5.30;
no warnings;
my @ints = (4,6,3,8,15,0,13,18,7,16,14,19,17,5,11,1,12,2,9,10);
#@ints = (0,1,13,7,6,8,10,11,2,14,16,4,12,9,17,5,3,18,15,19);
#@ints = (9,8,3,11,5,7,13,19,12,4,14,10,18,2,16,1,0,15,6,17);
say "Input: \@ints = (" . join(", ", @ints) . ")";
print "Output: ";
my $str;
my @used;
for my $i (0 .. $#ints) {
    next if ($ints[$i] ~~ @used);
    my $ret = cycle($i);
    if ($ret == -1) {
	break;
    } else {
	push @used, @$ret;
    }
}
my $n = $str =~ tr/\n//;
say $n;
print $str;
sub cycle {
    my $i = shift;
    my $I = $ints[$i];
    if ($i == $I) {
	$str .= "\t[$I]\n";
	return [$I];
    }
    my @L;
    push @L, $I;    
    my $count;
    while(1) {
	$I = $ints[$I];
	push @L, $I;
	if ($L[0] == $I) {
	    $str .= "\t[@L]\n";
	    return \@L;
	} else {
	    $count++;
	}
	if ($count == $#ints + 1) {
	    $str = "[@L]";
	    return -1;
	}
    };
}
