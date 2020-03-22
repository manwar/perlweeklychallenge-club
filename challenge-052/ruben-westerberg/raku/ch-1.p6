#!/usr/bin/env raku

my ($start,$end)=(@*ARGS[0]//100, @*ARGS[1]//999).sort;
#die "Arguments are not in range\n" unless 2 == 
die "Arguments not in range\n"  unless 2 == ($start,$end).grep({100 <= $_ <= 999});

($start..$end)==>
grep({
	my @a=$_.comb;
	my @b=@a.rotate(-1);
	my @diff=@a >>-<< @b;
	@a-1 == @diff[1..*-1].grep({ $_ == 1});

})==>my @stepping;

put "Stepping Number: $_" for @stepping;
