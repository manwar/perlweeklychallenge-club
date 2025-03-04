use v5.38;
use List::Util 'sum';

sub sum_it($str, $int) {
    my $sum;
    for my $i (0 .. length($str) / $int) {
	my $s = substr $str, $i*$int, $int;
	$sum .= sum(split '', $s) if ($s);
    }
    return $sum;
}

sub proc($str, $int) {
    say "Input: \$str = $str, \$int = $int";
    $str =~ s/\s//g;
    my $sum = sum_it($str, $int);
    unless (length $sum <= $int) {
	do {
	    my $oldsum = $sum;
	    $sum = sum_it($oldsum, $int);
	} while (length $sum > $int);
    }
    say "Output: $sum";
}

my $str = "111122333";
my $int = 3;
proc($str, $int);
$str = "1222312";
$int = 2;
proc($str, $int);
$str = "1000 1212 1001";
$int = 4;
proc($str, $int);
