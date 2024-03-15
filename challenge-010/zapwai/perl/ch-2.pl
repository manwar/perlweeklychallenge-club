use v5.38;
use List::Util qw( max min );

sub jw($s1, $s2) {
    my $jsim = jsim($s1, $s2);
    my $p = 0.1;
    my $l = 0;
    my @s1 = split "", $s1;
    my @s2 = split "", $s2;
    for (0 .. 4) {
	$l++ if ($s1[$_] eq $s2[$_]);
    }
    my $wsim = $jsim + $l*$p*(1 - $jsim);
    1 - $wsim
}

sub jsim($s1, $s2) {
    my ($l1, $l2) = (length $s1, length $s2);
    my $offset = max($l1, $l2) / 2;
    my ($m, $t) = num_matches($s1, $s2, $offset);
    return ($m > 0) ? 1/3 * ($m/$l1 + $m/$l2 + ($m - $t)/$m) : 0;
}

sub num_matches($s1, $s2, $offset) {
    my @s1 = split "", $s1;
    my @s2 = split "", $s2;
    my $cnt = 0;
    my $trans = 0;
  out:    for my $i (0 .. $#s1) {
	for my $j (0 .. $#s2) {
	    if (abs($i - $j) < $offset) {
		if ($s1[$i] eq $s2[$j]) {
		    $cnt++;
		    $trans++ if ($i != $j) && ((($i + 1 <= $#s1) && ($s1[$i] eq $s2[$i + 1]) && ($s2[$i] eq $s1[$i + 1])) || (($i - 1 >= 0) && ($s1[$i] eq $s2[$i - 1]) && ($s2[$i] eq $s1[$i - 1])));
		    next out;
		}
	    }
	}
    }
    return ($cnt, int $trans/2);
}

my $s1 = "faremviel";
my $s2 = "farmville";
say jw($s1, $s2);
