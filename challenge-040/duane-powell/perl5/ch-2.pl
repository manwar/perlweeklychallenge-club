#!/usr/bin/perl
use warnings;
use strict;
use feature qw( say );

my @a = qw( 10 4 1 8 12 3 );
my @i = qw( 0 2 5);


say join(',',@a);
my @temp;
foreach (@i) {
	push @temp, $a[$_];
}
@temp = sort {$a <=> $b} @temp;
foreach (@i) {
	$a[$_] = shift @temp;
}
say join(',',@a);

__END__

./ch-2.pl
10,4,1,8,12,3
1,4,3,8,12,10
