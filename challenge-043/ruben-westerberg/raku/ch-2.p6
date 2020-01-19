#!/usr/bin/env perl6

my $base=@*ARGS[0]||4;
my $i=baseToDec($base,"1"~"0"x($base-1));
my $num=decToBase($base,$i);
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
	$num=decToBase($base,$i);
	last if $num.chars > $base;
}
say "Found Self Describing Numbers:";
say $_ for @found;




sub baseToDec ($base,$value) {
	my $sum=0;
	for $value.comb.reverse {
		state $i=0;
		$sum+=$base**$i++*$_;
	}
	$sum;
}

sub decToBase ($base,$decIn) {
	return "0" if $decIn==0;
	my $dec=$decIn;
	my $rem;
	my $result="";
	while $dec {
		$rem=$dec%$base;
		$result~=$rem <= 9??$rem!!chr(55+$rem);	
		$dec=Int($dec/$base);
	}
	$result.flip;
}

sub test ($base,$nString) {
	return False if $nString.chars != $base;
	my $res=1;
	my @digits=$nString.comb;
	my $i=0;	
	for @digits -> $d {
		my $count=@digits.grep({$_ eq $i});
		my $bcount=decToBase($base,$count);	
		$res&&=(decToBase($base,$count) eq $d);
		last unless $res;
		$i++;
	}
	$res;
}
