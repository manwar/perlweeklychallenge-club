#!/usr/bin/env perl
use v5.30.0;
my $list1 = [1,5,1,1,6,4];
my $list2 = [1,3,2,2,3,1];
for my $ref ($list1, $list2) {
    my @list = @$ref;
    say "Input: \@list: (".join(",", @list).")";
    my $cnt;
    do {
	$cnt=0;
	for (0 .. $#list) {
	    if ($_ % 2 == 0) {
		wiggle(\$cnt, \@list) if ($list[$_ + 1] < $list[$_]);
	    } else {
		wiggle(\$cnt, \@list) if ($list[$_ + 1] > $list[$_]);
	    }
	}
    }    while ($cnt > 0);
    say "Output: (".join(",", @list).")";
}
sub wiggle {
    my ($cnt, $list) = @_;
    $$cnt++;
    ($$list[$_],$$list[$_ + 1]) = ($$list[$_+1], $$list[$_]);
}
