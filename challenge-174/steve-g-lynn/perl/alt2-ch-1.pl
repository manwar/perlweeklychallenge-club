#!/usr/bin/env perl

#real	0m1.660s
#user	0m1.652s
#sys	0m0.005s

#faster algorithm. 
#See my blog: https://thiujiac.blogspot.com/2022/07/pwc-174.html

for my $i (0 .. 9) { print "$i\n"; }
for my $i (2 .. 650_000 ) { &disarium($i) && (print &disarium($i),"\n" ); }

sub disarium {
	#-- inputs
	my ($n)=@_;
	my (@nstr)=split(//,$n);
	my @indx = 2..(scalar(@nstr)+1);
	my $retval=0;
	
	#-- calculate a^2+b^3+c^4 ... for $n=abc...
	for my $i (0..(@nstr-1)) {
	    $retval += ($nstr[$i] ** $indx[$i]);
  	}
  	
  	#check if $retval is divisible by 10^length($n)-1
  	my $x = (10 ** @nstr) - 1;
  	
  	#if divisible construct and return disarium number
  	if ( ( ($retval-$n) % $x ) == 0 && (($retval-$n) > 0) ) {
  		return int( ($retval-$n)/$x ) . $n;
  	} 
  	return undef;
}

