#!/usr/bin/env perl
use v5.30.0;
my @list = (1, 0, 3, 0, 0, 5);
# my @list = (0, 1, 0, 2, 0);

say "Input: (".join(",", @list).")";
my $numzeros = 0;
foreach (@list) {
    $numzeros++ if $_ == 0;
}
my $nonzero = @list - $numzeros - 1; # index of last nonzero entry
sub swap {
    for (0 .. $#list - 1) {
	if ($list[$_] == 0) {
	    $list[$_] = $list[$_ + 1];
	    $list[$_ + 1] = 0;
	}
    }
}
my $flag;
do {
    $flag=0;
    swap();
    foreach (0 .. $#list) {
	$flag++ if (($_ <= $nonzero) && ($list[$_] == 0));
    }
} while ($flag);
say "Output: (".join(",", @list).")";
