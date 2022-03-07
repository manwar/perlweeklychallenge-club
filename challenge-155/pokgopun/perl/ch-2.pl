use strict;
use warnings;
use Math::Base::Convert;

## Take n from argument if specified when running the script otherwise assign 3 which is the number the challenge's task asked to solve
## Support n = 1 to 36

my $n = shift;
$n = 3 unless $n;
die "n has to be an interger between 1 and 36\n" unless $n && $n =~ /^\d+$/ && $n <= 36;

my($conv4n2d,$conv4d2n);
{
	last unless $n > 10;
	my $baseChar = [@{[0..9,'A'..'Z']}[0..$n-1]];
	$conv4n2d = new Math::Base::Convert( $baseChar, '10');
	$conv4d2n = new Math::Base::Convert('10', $baseChar);
}

## Initial sequence of Fibonacci numbers, only need two to calculate the next one

my $fseq = "0 + 1";

## Initial Sequence of Fibonacci numbers modulo n, Fi modulo n

my $mseq = '';
my $i = 0;

## Detect repeated cycle, start from period of j = 1

my $j = 1;

{
	## Calcuate next Fibonacci number

	#my $f = eval($fseq);
	
	## Extracting Fi from the sequence and replace the squence with the latest two numbers
	## For Fibonacci number modulo 10, we only need the last digit of the number to calculate 

	#my $fi;
	#($fi, $fseq) = $fseq =~ /(\d+) \+ (\d+)/ && $n==10 ? (substr($1,-1), join(" + ",substr($2,-1),substr($f,-1))) : ($1, "$2 + $f");
	
	## Generate sequence of Fi modulo n

	#$mseq .= $fi % $n;

	## Evolve from the logic above for n==10, we can do the same for n > 10 by converting to base n before store/use the last base char 
	
	$fseq =~ /(\w+) \+ (\w+)/;
	my $f = $n > 10 ? $conv4n2d->cnv($1) + $conv4n2d->cnv($2) : $1 + $2;
	my $fi;
	($fi, $fseq) = $n < 10 ? ($1, "$2 + $f") :
			$n == 10 ? ( substr($1,-1), join(" + ", map{substr($_,-1)} ($2,$f)) ) :
			( scalar($conv4n2d->cnv(substr($1,-1))), join(" + ", map{substr($_,-1)} ($2,scalar($conv4d2n->cnv($f)))) );
	$mseq .= $n > 10 ? $conv4d2n->cnv($fi % $n) : $fi % $n;
	
	## When the sequence reach j * 2, check for a repeated period of j
	## If found, display j and the repeated cycle and exit the loop
	## If not, continue the loop to check the period of j + 1
	
	if ( $j * 2 == length($mseq) ){
		if( substr($mseq,0,$j) eq substr($mseq,-$j) ){
			print "#$n Pisano Period is ".$j." => ".substr($mseq,0,$j)."\n";
			last;
		}
		$j++;
	}

	## Continue with the next Fi
	
	$i++;
	redo; 
}
