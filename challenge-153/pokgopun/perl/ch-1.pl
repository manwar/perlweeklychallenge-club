use strict;
use warnings;

my $res;
foreach my $n (1..10) {
	### Left factorial which is known by the other name as subfactorial but it does not produce output similar to the example
	#$res .= sprintf "%s, ", eval(join(" + ", map{ &factorial($n) / &factorial($_) * (-1)**$_ } 0..$n ));
	### The below seems to produce output similar to the example
	$res .= sprintf "%s, ", eval( join( " + ", map{&factorial($_)} 0..$n-1 ) );
}
$res =~ s/\D+$//;
printf "%s\n", $res;
sub factorial { 
	my $n = shift;
	return $n==0 ? 1 : eval(join(" * ", 1..$n));
}

