use v6;

sub proc($n, @list) {
    say "Input: \@list = ", @list, " \$n = $n";
    my $k = (@list / $n).int;
    my $r = @list % $n;
    if $k == 0 {
	say "Output: -1";
	return;
    }
    my @a;
    my @first = @list[0 ..^ $k + $r];
    push @a, @first;
    for 1 ..^ $n -> $i {
	my @arr;
	for 0 ..^ $k -> $j {
	    push @arr, @list[$j + $k*$i + $r];
	}
	push @a, @arr;
    }
    say "Output: ", @a;
}

my @list = (1 .. 5); my $n = 2;
proc($n, @list);
@list = (1 .. 6); $n = 3;
proc($n, @list);
@list = (1,2,3); $n = 2;
proc($n, @list);
@list = (1 .. 10); $n = 5;
proc($n, @list);
@list = (1,2,3); $n = 4;
proc($n, @list);
