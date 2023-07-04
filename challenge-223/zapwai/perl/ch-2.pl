use v5.30;
my @box = (3, 1, 5, 8);
say "Input: \@box = [@box]";
my ($sum, $max) = (0, 0);
my (@soln, @arr, $out_string, $current_string);
my $n = $#box + 1;
fill(\@arr, $n);
for my $s (@arr) {
    $current_string = "";
    $s = join("", reverse split("", $s));
    my @bits = split("", $s);
    my @boxcopy = @box;
    for my $i (0 .. $n - 1) {
	spl_sum(\@boxcopy, int $bits[$i] );
    }
    if ($max < $sum) {
	$max = $sum;
	@soln = @bits;
	$out_string = $current_string;
    }
    $sum = 0;
}
say "Output: $max";
say "\tChoose indices: @soln";
say $out_string;
sub fill() {
    my ($r, $n) = @_;
    push @$r, "0";
    for my $i (2 .. $n) {
	for my $j (0 .. $i-1) {
	    for my $a (@$r) {
		next if (length $a != $i - 1);
		push @$r, $a.$j;
	    }
	}
    }
    for my $i (reverse (0 .. $#{$r} - 1)) {
	splice(@$r, $i, 1) if (length ${$r}[$i] < $n);
    }
}
sub spl_sum() {
    my ($ref, $i) = @_;
    my $val = splice(@$ref, $i, 1);
    my $l = ($i >= 1) ? ${$ref}[$i - 1] : 1;
    my $r = ($i < scalar @$ref) ? ${$ref}[$i] : 1;
    my $prod = $val*$l*$r;
    $current_string .= "\t$l x $val x $r => $prod";
    $current_string .= ", Current Box: @$ref\n" if (@$ref);
    $sum += $prod;
}
