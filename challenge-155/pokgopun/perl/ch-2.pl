use strict;
use warnings;

## Take n from argument if specified when running the script otherwise assign 3 which is the number the challenge's task asked to solve

my $n = shift;
$n = 3 unless $n;

## Initial sequence of Fibonacci numbers, only need two to calculate the next one

my @f = qw/0 1/;

## Initial Sequence of Fibonacci numbers modulo n, Fi modulo n

my $mseq = '';
my $i = 0;

{
	## Calculate next F number, modulo n first before pushing to @f and take off Fi
	## this to keep @f minimal while Fi modulo n still produce the same result

	push @f, ($f[0] + $f[1]) % $n;
	my $fi = shift @f;

	## Get offset to convert number 0..35 to char 0..9,A..Z ,
	## 36... to char a..z and whatever come next in ascii table
	## This make the repeated cycle in $mseq comparable
	
	my $o = $fi < 10 ? 48 :
		$fi < 36 ? 55 : 61;
	
	$mseq .= chr(($fi % $n) + $o); 

	## Check for repeated cycle when number char of sequence is even (i.e. when $i is odd ), compare 1st and 2nd half
	
	if ( $i % 2 == 1 ){
		my $l = ($i + 1)/2;
		if( substr($mseq,0,$l) eq substr($mseq,-$l) ){
			print "#$n Pisano period is ".$l.", repeated cycle is ".substr($mseq,0,$l)."\n";
			last;
		}
	}

	## Continue with the next Fi
	
	$i++;
	redo; 
}
