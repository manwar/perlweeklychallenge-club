#! /usr/bin/env rakudo

my @A = (1, 5, 0, 2, 9, 3, 7, 6, 4, 8);
my $S = 3;

sub min-in-window(:$array, :$window where $window > 0 ) {
	gather for (0 .. $array.elems - $window) -> $i {
		take min($array[$i .. $i + $window - 1]);
	}
}

say min-in-window :array(@A), :window($S);
#say min-window :array(['red', 'white', 'blue', 999, 0, 'yellow']), :window(2);
