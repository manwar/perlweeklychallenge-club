# THE WEEKLY CHALLENGE - 173
# Task 2: Sylvester’s sequence
# Autore: Dario Mazzeo

my $prod=2;
my $prec=1;
print "$prod\n";
foreach my $i (1 .. 9){
	$prod=$prec*$prod;
	$prec=$prod;
	$prod++;
	print "$prod\n";
}