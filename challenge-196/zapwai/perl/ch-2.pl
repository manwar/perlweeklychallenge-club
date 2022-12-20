#!/usr/bin/env perl
my @list1 = (1,3,4,5,7);
my @list2 = (1,2,3,6,7,9);
my @list3 = (0,1,2,4,5,6,8,9);
my @lists = (\@list1, \@list2, \@list3);

for my $ref (@lists) {
    my @list = @{$ref};
    print "Input: (".join(",",@list).")\n";
    print "Output: ";

    my $range_flag = 0;
    my $comma_flag = 0;
    for my $index (0 .. $#list) {
	if ($list[$index + 1] == $list[$index] + 1) {
	    if (!$range_flag) {
		$range_flag = 1;
		print ", " if ($comma_flag);
		print "[$list[$index],";
	    }
	} else {
	    if ($range_flag) {
		$range_flag = 0;
		$comma_flag = 1;
		print "$list[$index]]";
	    }
	}
    }
    print "\n";
}
