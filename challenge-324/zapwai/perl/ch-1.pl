use v5.40;

sub proc($r, $c, @ints) {
    say "Input: \@ints = @ints, \$r = $r, \$c = $c";
    die "wrong dimensions for this data" if (@ints != $r * $c);
    my $cell = 0;
    my @o;
    for my $row (1 .. $r) {
	my @x;
	for my $col (1 .. $c) {
	    push @x, $ints[$cell++];
	}
	push @o, \@x;
    }
    say "Output: ";
    say "@$_" foreach (@o);
}

my @ints = (1, 2, 3, 4); my $r = 2; my $c = 2;
proc($r, $c, @ints);
@ints = (1, 2, 3); $r = 1; $c = 3;
proc($r, $c, @ints);
@ints = (1, 2, 3, 4); $r = 4; $c = 1;
proc($r, $c, @ints);
