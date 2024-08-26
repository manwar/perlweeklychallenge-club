use v5.38;
my @list1 = (2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5);
my @list2 = (2, 1, 4, 3, 5, 6);
proc(\@list1, \@list2);
@list1 = (3, 3, 4, 6, 2, 4, 2, 1, 3);
@list2 = (1, 3, 2);
proc(\@list1, \@list2);
@list1 = (3, 0, 5, 0, 2, 1, 4, 1, 1);
@list2 = (1, 0, 3, 2);
proc(\@list1, \@list2);

sub proc($l1, $l2) {
    say "Input: \n \@list1 = @{$l1}\n \@list2 = @{$l2}";
    my @tail;
    for my $item (@list1) {
	my $elem_of_l2_flag = 0;
	for my $item2 (@list2) {
	    if ($item == $item2) {
		$elem_of_l2_flag = 1;
		last;
	    }
	}
	if ($elem_of_l2_flag == 0) {
	    push @tail, $item;
	}
    }
    my @pre;
    for my $item2 (@list2) {
	for my $item (@list1) {
	    if ($item == $item2) {
		push @pre, $item;
	    }
	}
    }
    my @sorted_tail = sort { $a <=> $b } @tail;
    say "Output: @pre @sorted_tail";
}
