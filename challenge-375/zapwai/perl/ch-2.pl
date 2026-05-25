use v5.38;
sub proc($num, $k) {
    say "Input: \$num = $num, \$k = $k";
    my @a;
    for my $i (0 .. length ($num) - $k) {
	push @a, substr($num, $i, $k);
    }
    my $cnt = 0;
    for (@a) {
	$cnt++ if ($num % $_ == 0);
    }
    say "Output: $cnt";
}

my $num = 240; my $k = 2;
proc($num, $k);
($num, $k) = (1020, 2);
proc($num, $k);
($num, $k) = (444, 2);
proc($num, $k);
($num, $k) = (17, 2);
proc($num, $k);
($num, $k) = (123, 1);
proc($num, $k);
