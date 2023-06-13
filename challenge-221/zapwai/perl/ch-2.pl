use v5.30;
my @ints1 = (9, 4, 7, 2, 10);
my @ints2 = (3, 6, 9, 12);
my @ints3 = (20, 1, 15, 3, 10, 5, 8);
my @I = (\@ints1, \@ints2, \@ints3);
foreach (@I) {
    my @ints = @$_;
    my @list;

    my $d = $#ints + 1;
    my $format = "%0$d" . "b\n";
    for (0 .. 2 ** $d - 1) {
	my $s = sprintf($format,$_);
	my @bits = split "", $s;
	my @L;
	for my $i (0 .. $#ints) {
	    push @L, $ints[$i] if ($bits[$i]);
	}
	push @list, \@L unless ($#L < 2);
    }

    my $max=0;
    my $str;
    foreach my $ref ( @list ) {
	my $c =  is_arit($ref);
	if ($max < $c) {
	    $max = $c;
	    $str = "(" . join(",",@$ref) . ")";
	}
    }
    say "Input: \@ints = (" . join(",",@ints) . ")";
    say "Output: " . ($max+1);
    say $str;
}

sub is_arit {
    my $r = shift;
    my @A = @$r;
    return 0 if ($#A <= 1);
    my $cnt = 0;
    my $K = $A[1] - $A[0];
    for my $i (1 .. $#A - 1) {
	$cnt++ if ( $A[$i + 1] - $A[$i] == $K );
    }
    return $#A if ($cnt == $#A - 1);
    0
}
