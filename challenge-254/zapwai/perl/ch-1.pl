use v5.30;
my $n = 27;
#$n = 0;
#$n = 6;


    say "Input: \$n = $n";
    my $output = div3($n);
    if ($output >= 0) {
	say "Output: True, $n = 3^", $output;
    } else {
	say "Output: False";
    }

sub div3() {
    my $n = shift;
    my $powflag = 0;
    my $endflag = 0;
    my $cnt = 0;
    do {
	$n = $n / 3;
	$cnt++;
	if ($n == 1) {	
	   $endflag = 1;
	   $powflag = 1;
	} elsif ($n == 0) {
	   $endflag = 1;
	} elsif (int $n != $n) {
	   $endflag = 1;
	}
    } until ($endflag);
    if ($powflag) {
	return $cnt;
    } else {
	return -1;
    }
}