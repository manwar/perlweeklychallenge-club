use v5.38;

sub cum($lvl, @n) {
    my $cnt = 0;
    for my $n (@n) {
	$cnt++ if ($lvl > $n);
    }
    return $cnt;
}

sub proc(@n) {
    say "Input : @n";
    my @n2;
    push @n2, cum($_, @n) for (@n);
    say "Output: @n2";
}

my @n = (6,5,4,8);
proc(@n);
@n = (7,7,7,7);
proc(@n);
@n = (5,4,3,2,1);
proc(@n);
@n = (-1, 0,3,-2,1);
proc(@n);
@n = (0,1,1,2,0);
proc(@n);
