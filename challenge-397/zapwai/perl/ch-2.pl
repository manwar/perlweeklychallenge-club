use v5.38;

sub binref($a) {
    return scalar reverse sprintf("%b", $a);
}

sub proc(@a) {
    say "Input: @a";
    @a = sort {$a <=> $b} @a;
    my @b = map {binref($_)} @a;
    my $flag = 1;
    while ($flag != 0) {
	$flag = 0;
	for my $i (0 .. $#b - 1) {
	    if ($b[$i] > $b[$i+1]) {
		$flag++;
		my $tmp = $b[$i];
		$b[$i] = $b[$i+1];
		$b[$i+1] = $tmp;
		$tmp = $a[$i];
		$a[$i] = $a[$i+1];
		$a[$i+1] = $tmp;
	    }
	}
    }
    say "Output: @a";
}

my @a = (3, 6, 12);
proc(@a);
@a = (1,2,4,8);
proc(@a);
@a = (7, 8, 9, 10);
proc(@a);
@a = (5, 9, 15, 17);
proc(@a);
@a = (11, 13, 14, 19);
proc(@a);
