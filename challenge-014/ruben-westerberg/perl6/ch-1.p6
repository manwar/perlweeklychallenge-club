#!/usr/bin/env perl6

my $nn = @*ARGS[0]//10;
die "Please specify an argument greater or equal to 0 \n" if $nn < 0;
my @a=(0);
for 0..^$nn -> $n {
	my $max= @a[0..^$n].grep(@a[$n],:k).max();
	@a[$n+1]=$max == -Inf??0!!$n-$max;
}
put join ", ",@a;
