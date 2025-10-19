use v5.38;

sub proc($str) {
    say "Input: $str";
    my $max = 0;
    for my $len (1 .. length( $str ) - 1) {
	my $pre = substr $str, 0, $len;
	my $post = substr $str, $len;
	my $left_sum = 0; # Sum of zeros on left
	my $right_sum = 0; # Sum of ones on right
	for my $n (split '', $pre) {
	    $left_sum++ if ($n eq "0");
	}
	for my $n (split '', $post) {
	    $right_sum++ if ($n eq "1");
	}
	my $total = $left_sum + $right_sum;
	if ($max < $total) {
	    $max = $total;
	}
    }
    say "Output: $max";
}

my $str = "0011";
proc($str);
$str = "0000";
proc($str);
$str = "1111";
proc($str);
$str = "0101";
proc($str);
$str = "011101";
proc($str);
