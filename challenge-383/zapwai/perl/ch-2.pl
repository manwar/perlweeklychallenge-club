use v5.38;

sub to_dec($code) {
    my $str = "0123456789ABCDEF";
    my ($c, $d) = split '', $code;
    my $val1 = 16*(index $str, $c);
    my $val2 = index $str, $d;
    return $val1 + $val2;
}

sub proc($color) {
    say "Input: \"$color\"";
    my @chunk = map {substr $color, $_, 2} (1,3,5);
    my @val = map { to_dec($_) } @chunk;
    my @safe_dec = (0, 51, 102, 153, 204, 255);
    my @safe_val = qw(00 33 66 99 CC FF);
    my $o;
    my @min_ind;
    for my $val (@val) {
	my $min = 256;
	my $minimum_index = 0;
	for my $i (0 .. $#safe_dec) {
	    my $diff = abs($val - $safe_dec[$i]);
	    if ($min > $diff) {
		$min = $diff;
		$minimum_index = $i;
	    }
	}
	push @min_ind, $minimum_index;
    }
    $o .= $safe_val[$_] for (@min_ind);
    say "Output:\"#$o\"";
}

my $color = "#F4B2D1";
proc($color);
$color = "#15E6E5";
proc($color);
$color = "#191A65";
proc($color);
$color = "#2D5A1B";
proc($color);
$color = "#00FF66";
proc($color);
