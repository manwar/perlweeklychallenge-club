# THE WEEKLY CHALLENGE - 188
# Task 2: Total Zero
# Autore: Dario Mazzeo

print NumeroDiOperazioni(5,4)."\n";
exit;

sub NumeroDiOperazioni{
my ($x,$y)=($_[0], $_[1]);

my $n=0;
do{
	if ($x>=$y){$x-=$y;}
	else{$y-=$x;}
	$n++;
}while (abs($x-$y)>0);
return ++$n;
}