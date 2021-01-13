#!/usr/bin/env raku

my $max=10;
my @N= $max.rand().Int xx $max; #sort map { int rand $max } 1..$max;
my $k=2;

say "Input Array:";
put @N.join: ", ";

my @results;

loop (my $i=0; $i < @N; $i++) {
	loop (my $j=0; $j < @N; $j++) {
		@results.push: [$i,$j] if @N[$i]-@N[$j] == $k and $i != $j;
	}
}
put "Index pairs for difference of $k:";
printf("%d, %d\n",$_[0],$_[1]) for @results;

