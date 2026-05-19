use v5.38;

sub proc($n, @l) {
    say "Input: \@list = @l, \$n = $n";
    my $k = int @l/$n;
    my $r = @l % $n;
    if ($k == 0) {
	say "Output: -1";
	return;
    }
    my @a;
    my @first;
    for my $i (0 .. $k + $r - 1) {
	push @first, $l[$i];
    }
    push @a, \@first;
    for my $j (1 .. $n - 1) {
	my @arr;
	for my $i (0 .. $k - 1) {
	    push @arr, $l[$i + $j*$k + $r];
	}
	push @a, \@arr;
    }
    print "Output: ";
    print "(@$_) " for (@a);
    say "";
}

my @list = (1,2,3,4,5); my $n = 2;
proc($n, @list);
@list = (1,2,3,4,5,6); $n = 3;
proc($n, @list);
@list = (1,2,3); $n = 2;
proc($n, @list);
@list = (1 .. 10); $n = 5;
proc($n, @list);
@list = (1,2,3); $n = 4;
proc($n, @list);
