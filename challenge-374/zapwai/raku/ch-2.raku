use v6;

sub proc($s) {
    say "Input: $s";
    my @d = $s.comb;
    my @num;
    my $num = @d[0];
    for 0 ..^ @d.end -> $i {
	if @d[$i] != @d[$i+1] {
	    @num.push($num);
	    $num = @d[$i+1];
	} else {
	    $num ~= @d[$i+1];
	}
    }
    @num.push($num);
    say "Output: " ~ (@num>>.Numeric).max;
}

my $s = 6777133339;
proc($s);
$s = 1200034;
proc($s);
$s = 44221155;
proc($s);
$s = 88888;
proc($s);
$s = 11122233;
proc($s);
