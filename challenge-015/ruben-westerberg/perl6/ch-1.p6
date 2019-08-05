#!/usr/bin/env perl6

my (@week,@balanced, @strong);
my @p=(@week, @balanced, @strong);
my @ps;
my @primes=(2..*).grep: *.is-prime;
my $i=0;
while @week < 10 or @strong < 10 {
	@ps.push: @primes[$i];
	next if $i++ < 2;
	@p[((@ps[1] <=> (sum(@ps[0,2])/2)).value+1)].push: @ps[1];
	@ps.shift;
}
put "Week:   ",@week[^10].join: ", ";
put "Strong: ",@strong[^10].join: ", ";
