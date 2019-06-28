#!/usr/bin/env perl
use List::Util qw<max>;

my $nn = $ARGV[0]//10;
die "Please specify an argument greater or equal to 0 \n" if $nn < 0;
my @a=(0);
for my $n (0..$nn-1) {
	my $max=max grep {$a[$_]==$a[$n]} (0..$n-1);
	$a[$n+1]=defined $max?$n-$max:0;
}
print join ", ",@a;
print "\n";
