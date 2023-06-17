my @ints1 = (9, 4, 7, 2, 10);
my @ints2 = (3, 6, 9, 12);
my @ints3 = (20, 1, 15, 3, 10, 5, 8);
my @I = (@ints1, @ints2, @ints3);
for @I -> @ints {
    my @list;
    my $d = @ints.elems;
    my $format = "%0$d" ~ 'b';
    for (0 .. 2 ** $d - 1) {
	my $s = sprintf($format,$_);
	my @bits = split("", $s, :skip-empty);
	my @L;
	for (0 .. @ints.elems - 1) -> $i {
	    push @L, @ints[$i] if @bits[$i] == "1";
	}
	push @list, @L unless (@L.elems < 3);
    }
    my $max=0;
    my $str;
    for @list -> @ref {
	my $c =  is_arit(@ref);
	if ($max < $c) {
	    $max = $c;
	    $str = "(" ~ join(",",@ref) ~ ")";
	}
    }
    say "Input: \@ints = (" ~ join(",",@ints) ~ ")";
    say "Output: " ~ ($max+1);
    say $str;
    say "-" x 10;
    
}

sub is_arit (@A) {
    return 0 if (@A.elems <= 2);
    my $cnt = 0;
    my $K = @A[1] - @A[0];
    for (1 .. @A.elems - 2) -> $i {
	$cnt++ if ( @A[$i + 1] - @A[$i] == $K );
    }
    return @A.elems-1 if ($cnt == @A.elems - 2);
    0
}
