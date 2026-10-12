use v5.38;

sub proc($n1, $n2) {
    say "Input: $n1, $n2";

    my ($re1, $im1) = split '\+', $n1;
    $im1 = substr $im1, 0, -1;

    my ($re2, $im2) = split '\+', $n2;
    $im2 = substr $im2, 0, -1;

    for ($re1, $re2, $im1, $im2) {
	if ($_ =~ /\(/) {
	    $_ = substr $_, 1, -1;
	}
    }

    my $real = $re1*$re2 - $im1*$im2;
    my $imag = $re1*$im2 + $im1*$re2;

    say "Output: $real+$imag"."i\n";
}

my $n1 = "1+1i";
my $n2 = "1+1i";
proc($n1, $n2);

$n1 = "1+(-1)i"; $n2 = "1+(-1)i";
proc($n1, $n2);
$n1 = "0+3i"; $n2 = "0+4i";
proc($n1, $n2);
$n1 = "3+4i"; $n2 = "3+(-4)i";
proc($n1, $n2);
$n1 = "50+(-20)i"; $n2 = "-10+30i";
proc($n1, $n2);
