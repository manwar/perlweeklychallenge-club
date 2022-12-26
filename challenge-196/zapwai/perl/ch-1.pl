#!/usr/bin/env perl
my @list;
my @testlist = ( [3,1,4,2],
		 [1,2,3,4],
		 [1,3,2,4,6,5],
		 [1,3,4,2],
	     );
for (@testlist) {
    @list = @{$_};    
    driver();
}
sub driver {
    print "Input: (".join(",",@list).")\n";
    print "Output: ";

    for my $i (0 .. $#list - 2) {
	for my $j ($i + 1 .. $#list -1) {
	    for my $k ($j + 1 .. $#list) {
		if ( ($list[$i] < $list[$k]) &&
		     ($list[$k] < $list[$j]) ) {
		    print "(", join(",",@list[$i, $j, $k]), ")\n";
		    return;
		}
	    }
	}
    }
    print "()\n";
}
