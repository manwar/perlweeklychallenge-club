my @box = (3, 1, 5, 8);
say "Input: \@box = [@box[]]";
my ($sum, $max) = (0, 0);
my (@soln, @arr, $out_string, $current_string);
my $n = @box.elems();
fill(@arr, $n);
for @arr -> $s {
    $current_string = "";    
    my @bits = $s.flip().split("", :skip-empty);
    my @boxcopy = @box.clone();
    for 0 .. $n - 1 -> $i {
	spl_sum(@boxcopy, @bits[$i].Int() );
    }
    if $max < $sum {
	$max = $sum;
	@soln = @bits;
	$out_string = $current_string;
    }
    $sum = 0;
}
say "Output: $max";
say "\tChoose indices: @soln[]";
say $out_string;
sub fill(@arr, $n) {
    push @arr, "0";
    for 2 .. $n -> $i {
	for 0 .. $i-1 -> $j {
	    for @arr -> $a {
		next if $a.chars != $i - 1;
		push @arr, $a~$j;
	    }
	}
    }
    for (0 .. @arr.elems - 1).reverse -> $i {
	splice(@arr, $i, 1) if @arr[$i].chars() < $n;
    }
    
}
sub spl_sum (@B, $i) {
    my $val = @B.splice($i,1)[0];
    my $l = @B[$i - 1] // 1;
    my $r = @B[$i] // 1;

    my $prod = $val*$l*$r;
    $current_string ~= "\t$l x $val x $r => $prod";
    $current_string ~= ", Current Box: @B[]\n" if (@B);
    $sum += $prod;
}
