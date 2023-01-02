my @list1 = (5,8,2,1,11,17,20,12,15);
my @list2 = ();
my @list3 = (2,5,1);
foreach my $ref (\@list1, \@list2, \@list3) {
    my @list = @$ref;
    print "Input: \@list = (".join(",",@list).")\n";
    @list = sort { $a <=> $b } @list;
    my $gap = 0;
    for (0 .. $#list - 1) {
	my $diff = $list[$_ + 1] - $list[$_];
	$gap = $diff if ($gap < $diff);
    }
    my @index;
    for (0 .. $#list - 1) {
	my $diff = $list[$_ + 1] - $list[$_];
	push @index, $_ if ($diff == $gap);
    }
    print "Output: ", (scalar @index)."\n";
    if (scalar @index > 1) {
	print "\nSince the sorted list (".
	    join(",",@list).") contains ".(scalar @index)." such pairs.\n";
	my @lists;
	foreach (@index) {
	    my $str = "(".$list[$_].", ".$list[$_+1].")";
	    push @lists, $str;
	}
	my $last = pop @lists;
	my $output = join(", ", @lists)." and $last";
	print $output."\n";
    } elsif (scalar @index == 1) {
	print "\n(".join(",",@list).") contains ";
	print "(".$list[$index[0]].", ".$list[$index[0]+1].")\n";
    }
    print "\n";
}
