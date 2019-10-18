use strict;
use warnings;
use v5.10;

my @numbers;

for my $first ( 1..10 ) {

	for my $second (1..10) {
		my $third = 12 - $first - $second;
		push @numbers, join ", ", sort ( $first, $second, $third ) if $third > 0;
	}
}
my %uniq;
$, = ";\n";
say sort grep !$uniq{$_}++, @numbers;
