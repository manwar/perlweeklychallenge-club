#!/usr/bin/env perl6

my $base=(@*ARGS[0]||4).Int;
my $i=("1"~"0"x($base-1)).parse-base($base);
my $num=$i.base($base);
my @found;
my $run=True;
signal(SIGINT).tap({say "Stopping search"; $run=False;});
while ($run) { 
	my $res=test($base,$num);
	if ($res) {
		put "***OK: $num***";
		@found.push: $num;
		sleep 1;
		
	}
	else {
		put "NO: $num";
	}
	$i++;
	$num=$i.base($base);
	last if $num.chars > $base;
}
say "Found Self Describing Numbers:";
say $_ for @found;


sub test ($base,$nString) {
	return False if $nString.chars != $base;
	my $res=1;
	my @digits=$nString.comb;
	my $i=0;	
	for @digits -> $d {
		my $count=@digits.grep({$_ eq $i});
		my $bcount=$count.Int.base($base);
		$res&&=($count.Int.base($base) eq $d);
		last unless $res;
		$i++;
	}
	$res;
}
