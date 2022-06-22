# THE WEEKLY CHALLENGE - 170
# Task 1: Primorial Numbers
# Autore: Dario Mazzeo

my @primi=(1, 2, 3, 5, 7, 11, 13, 17, 19, 23);
my $tmp=1;

for (my $i=0; $i<10; $i++){
	$tmp=$primi[$i]*$tmp;
	print "$tmp\n";
}