# THE WEEKLY CHALLENGE - 170
# Task 1: Primorial Numbers
# Autore: Dario Mazzeo

my @primi=(2, 3, 5, 7, 11, 13, 17, 19, 23, 29);
my @arr=();
$arr[0]=1;

for (my $i=0; $i<10; $i++){
	push(@arr, $primi[$i]*$arr[$i]);
	print "$arr[$i]\n";
}
