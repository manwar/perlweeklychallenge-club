# THE WEEKLY CHALLENGE - 172
# Task 2: Five-number Summary
# Autore: Dario Mazzeo

my @numeri=(0, 0, 1, 2, 63, 61, 27, 13);
#my @numeri=(77, 79, 80, 86, 87, 87, 94, 99);

@numeri=sort {$a <=> $b} @numeri;
my $min=$numeri[0];
my $max=$numeri[$#numeri];

my $mediana=0;
if ($#numeri/2 != int($#numeri/2)){$mediana=($numeri[int($#numeri/2)] + $numeri[int($#numeri/2)+1])/2;}
else{$mediana=$numeri[int($#numeri/2)]/2;}

my $primoquartile=0;
my $terzoquartile=0;
for (my $i=1; $i<=($#numeri+1)/4; $i++){
	$primoquartile+=$numeri[$i];
	$terzoquartile+=$numeri[$#numeri-$i];
}
$primoquartile/=($#numeri+1)/4;
$terzoquartile/=($#numeri+1)/4;

printf("%.2f, %.2f, %.2f, %.2f, %.2f\n", $min, $primoquartile, $mediana, $terzoquartile, $max);