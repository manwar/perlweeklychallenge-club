use v5.38;
# Return true if the list is lexically sorted
sub is_sorted(@l) {
    for my $i (0 .. $#l - 1) {
	return 0 if ($l[$i] gt $l[$i+1]);
    }
    1
}
sub proc(@list) {
    say "Input: \@list = @list";
    my $not_sorted = 0;
    my $len = length $list[0];
    for my $i (0 .. $len - 1) {
	my @l;
	for my $word (@list) {
	    push @l, substr $word, $i, 1;
	}
	unless (is_sorted(@l)) {
	    $not_sorted++;
	}
    }
    say "Output: $not_sorted";
}
my @list = ("swpc", "tyad", "azbe");
proc(@list);
@list = ("cba", "daf", "ghi");
proc(@list);
@list = ("a", "b", "c");
proc(@list);
