use v5.38;
my $alph = "abcdefghijklmnopqrstuvwxyz";

sub sum_digits($s) {
    my $sum = 0;
    my @d = split '', $s;
    $sum += $_ for (@d);
    return $sum;
}

sub conv($s) {
    my @l = split '', $s;
    my @num;
    for my $letter (@l) {
	my $ind = 1 + index $alph, $letter;
	push @num, $ind;
    }
    return join '', @num;
}

sub proc($str, $k) {
    say "Input: \$str = $str, \$k = $k";
    my $num = conv($str);
    for my $i (0 .. $k - 1) {
	$num = sum_digits($num);
    }
    say "Output: $num";
}

my $str = "abc"; my $k = 1;
proc($str, $k);
$str = "az"; $k = 2;
proc($str, $k);
$str = "cat"; $k = 1;
proc($str, $k);
$str = "dog"; $k = 2;
proc($str, $k);
$str = "perl"; $k = 3;
proc($str, $k);
