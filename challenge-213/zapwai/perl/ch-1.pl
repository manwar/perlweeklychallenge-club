use v5.30.0;
my @list = (1,2,3,4,5,6);
say "Input: \@list = (" . join(",",@list) . ")";
@list = sort @list;
my (@e, @o);
foreach (@list) {
    if ($_ % 2 == 0) {
	push @e, $_;
    }
    else {
	push @o, $_;
    }
}
say "Output: (" . join(",", @e, @o) . ")";
